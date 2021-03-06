package models

import (
    "github.com/coopernurse/gorp"
    "database/sql"
    "fmt"
    "os"
    "log"
    "time"
    _ "github.com/ziutek/mymysql/godrv"
    "github.com/nu7hatch/gouuid"
    "strings"
    "github.com/stathat/amzses"
    "github.com/stathat/jconfig"
    "crypto/sha1"
    "encoding/base64"
    "strconv"
    "jsonOutputs"
    "errors"
)


var (
    environment = os.Getenv("environment")
    config = jconfig.LoadConfig("/etc/aws.conf")
    port = config.GetString("dbport")
    dbusername = config.GetString("dbusername")
    dbpassword = config.GetString("dbpassword")
    db, connectionError = sql.Open("mymysql", "tcp:localhost:"+ port + "*" + "vsfootball/" + dbusername + "/"+ dbpassword)
    dbmap = &gorp.DbMap{Db: db, Dialect: gorp.MySQLDialect{"InnoDB", "UTF8"}}
)

func Init() {

    fmt.Println(connectionError)
    dbmap.AddTableWithName(User{}, "user").SetKeys(true,"Id")
    dbmap.AddTableWithName(Feedback{},"feedback").SetKeys(true,"Id")
    dbmap.AddTableWithName(Game{},"game").SetKeys(true,"Id")
    dbmap.AddTableWithName(Turn{},"turn").SetKeys(true,"Id")
    dbmap.CreateTables();
    dbmap.TraceOn("[gorp]", log.New(os.Stdout, "myapp:", log.Lmicroseconds))

    fmt.Println("database initialized.")  
}

func SendEmailVerification(email string) bool{
    query := "select user.Guid from user where Username = '" + email + "'"
    var results []*User
    _,err := dbmap.Select(&results,query)
    if(err != nil){
        return false
    } else {
        if(len(results) > 0){
            amzses.SendMail("info@engagemobile.com",email,"Verifcation of your Vsfootball account.","Please verify your Vsfootball account at vsf001.engagemobile.com/"+results[0].Guid+"/verify")    
            return true
        } else {
            return false
        }
    }
}

func ForgotPassword(email string) bool {
    query := "select user.Guid from user where Username = '" + email + "'"
    var results []*User
    res,userSearchErr := dbmap.Select(&results,query)

    fmt.Println(res)
    fmt.Println(userSearchErr)
    if(userSearchErr != nil){
        return false
    } else {
        if(len(results) > 0){
            rawGuid,guidErr := uuid.NewV4()
            if(guidErr != nil){
                fmt.Println(guidErr.Error())        
            }
            guid := strings.Split(rawGuid.String(),"-")

            hasher := sha1.New()
            hasher.Write([]byte(guid[0]))
            sha1output := base64.URLEncoding.EncodeToString(hasher.Sum(nil))
            updateQuery := "update user set user.Password= ? , user.Updated= ? where Guid=?"
            _,err := dbmap.Exec(updateQuery,sha1output,time.Now().UnixNano(),results[0].Guid)
            if(err != nil){
                fmt.Println(err)
                return false
            } else {
                amzses.SendMail("info@engagemobile.com",email,"Verifcation of your Vsfootball account.","Your temporary password is " + guid[0])    
                return true
            }
        } else {
            return false
        }
    }
}

func AddFeedback(feedback *Feedback) bool {
    err := dbmap.Insert(feedback)
    if(err == nil){
        return true
    } else {
        return false 
    }
}

func CreateAccount(user *User) error{
    query := "select * from user where user.Username ='"+user.Username +"'"
    var results []*User
    _,userSearchErr := dbmap.Select(&results,query)
    fmt.Println(results)
    fmt.Println(userSearchErr)
    if(len(results) > 0 && userSearchErr ==nil && results[0].Verified == 2 ){
        updateQuery := "update user set user.Firstname=?, user.Lastname=?,user.Platform=?,user.Updated=?,user.Verified=1 where user.Username=?"
        _,updateErr := dbmap.Exec(updateQuery,user.Firstname,user.Lastname,user.Platform,time.Now().UnixNano(),user.Username)
        return updateErr
    } else {
        if len(results)==0 {
            fmt.Println("in create account.",user)
            dbmap.Insert(user)
            amzses.SendMail("info@engagemobile.com",user.Username,"Verifcation of your Vsfootball account.","Please verify your Vsfootball account at vsf001.engagemobile.com/"+user.Guid+"/verify")
            return nil
        } else {
            return errors.New("1062")
        }
    }
        // fmt.Println("in create account.",user)
        // err2 := dbmap.Insert(user)

    return nil
}

func AccountLogin(username,password string) (string,error,int){
    query := "select user.Guid , user.Password, user.Verified from user where Username = '" + username +"'"
    var results []*User 
    _, err := dbmap.Select(&results,query)

    fmt.Println(err)
    if(err != nil){
        return "",err,0
    } else {
        if(len(results) > 0){
            if(password == results[0].Password){
                if(results[0].Verified == 0){
                    return results[0].Guid,nil,0
                } else{
                    return results[0].Guid,nil ,1                                   
                }
            } else {
                return "",nil,0 
            }
        } else{
            return "",nil,0
        }

    }
}

func FacebookSignup(user *User) (bool,string,string){
    query := "select user.Guid from user where user.Username='" +user.Username+"'"
    var results []*User
    _,err := dbmap.Select(&results,query)
    fmt.Println(err)
    if(err != nil){
        return false,err.Error(),""
    }
    if(len(results) > 0){
        return true,"Account Exists",results[0].Guid
    } else {
        createError := dbmap.Insert(user)
        if(createError != nil){
            return false,"Account creation failure",""
        }
        fmt.Println(createError)
        return true,"Account created.",user.Guid
    }
}

func VerifyAccount(guid string) bool {
    query :="update user set user.Verified=1, user.Updated=? where Guid = ?"
    res,err := dbmap.Exec(query,time.Now().UnixNano(),guid)
    fmt.Println(res)
    fmt.Println(err)
    return true
}
func CreateGame(guid,inviteEmail, possession, teamName, playIdSelected string) (string,bool,int64){
    query := "select user.Guid , user.Verified from user where Username = '" + inviteEmail +"'"
    var results []*User
    _,userSearchErr := dbmap.Select(&results,query)

    if(userSearchErr == nil && len(results) > 0){
        if(results[0].Verified !=0){
            game := &Game{
                Created: time.Now().UnixNano(),
                Player1:guid,
                Player2:results[0].Guid,
                Player1teamname:teamName,
                Player2teamname:"",
                Outcome:"",
                Player1accepteddate: time.Now().UnixNano(),
                Player2accepteddate:-1,
                Enddate:-1,
                Inviteaccepted:0}
            gameSaveErr := dbmap.Insert(game)
            if(gameSaveErr == nil){
                playID,_ := strconv.ParseInt(playIdSelected,10,64)
                turn := &Turn{
                    Gameid:game.Id,
                    Player1id:game.Player1,
                    Player2id:game.Player2,
                    Previousturn:-1,
                    Yardline:50,
                    Down:1,
                    Downdistance:10,
                    Player1playselected:playID,
                    Player2playselected:-1,
                    Player1role:possession,
                    Player2role:"",
                    Results:"",
                    Timeelapsedingame:0,
                    Currentplayer1score:0,
                    Currentplayer2score:0}
                turnSaveError :=dbmap.Insert(turn)
                if(turnSaveError == nil){
                    return "Awaiting confirmation from Player 2.",true,game.Id
                } else {
                    fmt.Println(turnSaveError)
                    return "Failed to save turn data.",false,-1
                }
            } 
            } else {
                return "User is not verified" ,false,-1
            }   
        } else {
            player2Guid,guidErr := uuid.NewV4()
            if(guidErr != nil){
                fmt.Println(guidErr.Error())        
            }
            user :=&User{
                Created:time.Now().UnixNano(),
                Updated:time.Now().UnixNano(),
                Firstname:"",
                Lastname:"",
                Guid:strings.Replace(player2Guid.String(),"-","",-1),
                Password:"",
                Accesstoken:"",
                Accounttype:"",
                Tokenexpiration:"",
                Username:inviteEmail,
                Verified:2,
                Playsowned:"",
                Platform:""}
            createAccountError := dbmap.Insert(user)
            if(createAccountError == nil){
                game := &Game{
                    Created: time.Now().UnixNano(),
                    Player1:guid,
                    Player2:user.Guid,
                    Player1teamname:teamName,
                    Player2teamname:"",
                    Outcome:"",
                    Player1accepteddate: time.Now().UnixNano(),
                    Player2accepteddate:-1,
                    Enddate:-1,
                    Inviteaccepted:0}
                gameSaveErr := dbmap.Insert(game)
                if(gameSaveErr == nil){
                playID,_ := strconv.ParseInt(playIdSelected,10,64)
                turn := &Turn{
                    Gameid:game.Id,
                    Player1id:game.Player1,
                    Player2id:game.Player2,
                    Previousturn:-1,
                    Yardline:50,
                    Down:1,
                    Downdistance:10,
                    Player1playselected:playID,
                    Player2playselected:-1,
                    Player1role:possession,
                    Player2role:"",
                    Results:"",
                    Timeelapsedingame:0,
                    Currentplayer1score:0,
                    Currentplayer2score:0}
                turnSaveError :=dbmap.Insert(turn)
                if(turnSaveError == nil){
                    return "Awaiting confirmation from Player 2.",true,game.Id
                } else {
                    fmt.Println(turnSaveError)
                    return "Failed to save turn data.",false,-1
                }
            }
        }
    }
    return "Error occured during game creation",false,-1
}

func GamesList(guid string) (bool,string,[]jsonOutputs.GameInList){
    query := "select * from game where game.player1 = '" + guid + "' or game.player2= '" + guid +"'"
    var gameList []*Game
    _,gamesListError :=dbmap.Select(&gameList,query)
    var gameListJson []jsonOutputs.GameInList
    if(gamesListError == nil){
        for game := range gameList {
            query := "select * from turn where turn.Gameid=" + strconv.FormatInt(gameList[game].Id,10)
            var turnList []*Turn
            _,turnsErr := dbmap.Select(&turnList,query)
            if(turnsErr ==nil){
                var turnsInGame []jsonOutputs.TurnInGame
                for turn := range turnList{
                    turnsInGame = append(turnsInGame,jsonOutputs.TurnInGame{
                        Id: turnList[turn].Id,
                        Player1id:turnList[turn].Player1id,
                        Player2id:turnList[turn].Player2id,
                        Previousturn:turnList[turn].Previousturn,
                        Yardline:turnList[turn].Yardline,
                        Down:turnList[turn].Down,
                        Downdistance:turnList[turn].Downdistance,
                        Player1playselected:turnList[turn].Player1playselected,
                        Player2playselected:turnList[turn].Player2playselected,
                        Player1role:turnList[turn].Player1role,
                        Player2role:turnList[turn].Player2role,
                        Results:turnList[turn].Results,
                        Playtime:turnList[turn].Playtime,
                        Timeelapsedingame:turnList[turn].Timeelapsedingame,
                        Currentplayer1score:turnList[turn].Currentplayer1score,
                        Currentplayer2score:turnList[turn].Currentplayer2score})
                }
                gameListJson = append(gameListJson,jsonOutputs.GameInList{
                Inviteaccepted:gameList[game].Inviteaccepted,
                Gameid : gameList[game].Id,
                Player1 : gameList[game].Player1,
                Player2 : gameList[game].Player2,
                Player1teamname : gameList[game].Player1teamname,
                Player2teamname : gameList[game].Player2teamname,
                Outcome : gameList[game].Outcome,
                Turns: turnsInGame })
            } else {
                return false,"Error gathering turn data", nil
            }
        }
    }else {
        return false,"Error gathering games.",nil
    }
    return true,"Successfully gathered game/turn data.",gameListJson
}

func ResignGame(guid,gameid string) bool {
    query := "select * from game where game.id='" + gameid + "'"
    var gameList []*Game
    _,gameErr := dbmap.Select(&gameList,query)
    if(len(gameList) >0  && gameErr ==nil){
        if(gameList[0].Player1 == guid || gameList[0].Player2 == guid){
            update := "update game set game.Outcome='Resigned:"+guid+"' where game.id="+gameid
            _,updateErr := dbmap.Exec(update)
            if(updateErr ==nil){
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    } else {
        fmt.Println(gameErr.Error())
        return false
    }
}

func ConfirmGame(guid,gameid string) bool{
    query := "update game set game.Inviteaccepted=1 where game.Id=" + gameid +" and (game.Player1='" + guid+ "' or game.Player2='" + guid+ "')"
    _,updateErr := dbmap.Exec(query)
    if(updateErr == nil){
        return true
    } else {
        fmt.Println(updateErr)
        return false
    }
}
func DbTest(){

    fmt.Print(dbmap)
    guid,guidErr := uuid.NewV4()
    if(guidErr != nil){
        fmt.Errorf(guidErr.Error())        
    }

    user := &User{
                    Created:time.Now().UnixNano(),
                    Updated:time.Now().UnixNano(),
                    Firstname:"Some",
                    Lastname:"CoolGuy",
                    Guid:strings.Replace(guid.String(),"-","",-1),
                    Password:"mycoolpw",
                    Accesstoken:"token",
                    Accounttype:"",
                    Tokenexpiration:""}

    dbmap.TraceOn("[gorp]", log.New(os.Stdout, "myapp:", log.Lmicroseconds))    
    err2 := dbmap.Insert(user)
    // fmt.Print(user)
    
    if(err2 != nil){
        fmt.Printf(err2.Error())        
    }

    // fmt.Printf(err2.Error())
    
    var list []*User 
    // obj,err3 := dbmap.Get(Weather{},0)
    _,err3 := dbmap.Select(&list,"select * from user")
    if(err3 != nil){
        fmt.Printf(err3.Error())        
    }


    for i := range list {
        fmt.Println(list[i])
    }
    // output := obj.(*Weather)
    

    // fmt.Printf(output.City)


}