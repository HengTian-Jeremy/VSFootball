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
            // fmt.Println(sha1output + " " + guid[0])
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
    fmt.Println("in create account.",user)
    err2 := dbmap.Insert(user)
    fmt.Println("out create account.")
    if(err2 == nil && environment != "development"){ 
        amzses.SendMail("info@engagemobile.com",user.Username,"Verifcation of your Vsfootball account.","Please verify your Vsfootball account at vsf001.engagemobile.com/"+user.Guid+"/verify")
    }
    return err2
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

func VerifyAccount(guid string) bool {
    query :="update user set user.Verified=1, user.Updated=? where Guid = ?"
    res,err := dbmap.Exec(query,time.Now().UnixNano(),guid)
    fmt.Println(res)
    fmt.Println(err)
    return true
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