package controllers

import (
	"net/http"
	"fmt"
	"encoding/json"
	"models"
	"jsonOutputs"
	"time"
	"strings"
	"github.com/nu7hatch/gouuid"
)

func HandleFacebookSignup (res http.ResponseWriter,request *http.Request){
	email := request.FormValue("email")
	accounttype := request.FormValue("accounttype")
	accesstoken := request.FormValue("accesstoken")
	tokenexpiration := request.FormValue("tokenexpiration")
	firstname := request.FormValue("firstname")
	lastname := request.FormValue("lastname")
	platform := request.FormValue("platform")
	output := jsonOutputs.LoginOutput{"false","Account creation was unsuccessful.",""}

	guid,guidErr := uuid.NewV4()
    if(guidErr != nil){
        fmt.Println(guidErr.Error())        
    }
	if(platform != ""){
        user :=&models.User{
        Created:time.Now().UnixNano(),
        Updated:time.Now().UnixNano(),
        Firstname:firstname,
        Lastname:lastname,
        Guid:strings.Replace(guid.String(),"-","",-1),
        Password:"",
        Accesstoken:accesstoken,
        Accounttype:accounttype,
        Tokenexpiration:tokenexpiration,
        Username:email,
        Verified:1,
        Playsowned:"",
        Platform:platform}
        success,message,guidReturn :=models.FacebookSignup(user)
        if(success){
        	output = jsonOutputs.LoginOutput{"true",message,guidReturn}	
        } else {
        	output = jsonOutputs.LoginOutput{"false",message,""}
        }
    }
    outputJson,_ :=json.Marshal(output)
	fmt.Fprintf(res,string(outputJson))	
}