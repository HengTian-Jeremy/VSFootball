package controllers

import (
	"net/http"
	"fmt"
	"encoding/json"
	"jsonOutputs"
	"models"
	"github.com/nu7hatch/gouuid"
	"time"
	"strings"
)
func HandleSignUp(res http.ResponseWriter,request *http.Request){
	emailAddress := request.FormValue("email")
	password := request.FormValue("password")
	firstname:= request.FormValue("firstname")
	lastname := request.FormValue("lastname")
    platform := request.FormValue("platform")
	emailLen := len(emailAddress)
	output := jsonOutputs.SuccessMessage{"false","Please populate necessary fields."}
	if 0 < emailLen && emailLen < 100{
		firstnameLen := len(firstname)
        if(0 < firstnameLen && firstnameLen < 50){
        	lastnameLen := len(lastname)
        	if(0 < lastnameLen && lastnameLen < 50){
        			passwordLen := len(password)
        		if(0 < passwordLen && passwordLen <= 40	){
        			
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
                        Password:password,
                        Accesstoken:"",
                        Accounttype:"",
                        Tokenexpiration:"",
                        Username:emailAddress,
                        Verified:0,
                        Playsowned:"",
                        Platform:platform}
                        err :=models.CreateAccount(user)
                        if(err != nil){
                            fmt.Println(err)
                            if(strings.Contains(err.Error(),"1062")){
                                output = jsonOutputs.SuccessMessage{"false","Account already exists with that username."}
                            } else {
                                output = jsonOutputs.SuccessMessage{"false","Our apologies an error has occured. Please try again later."}
                            }
                        } else {
                            output = jsonOutputs.SuccessMessage{"true","Successful account creation."}      
                        }    
                    }
        		}
        	}
    	}
	}
	outputJson,err :=json.Marshal(output)
	if(err == nil){
		fmt.Fprintf(res,string(outputJson))	
	} else{
		fmt.Fprintf(res,err.Error())
	}
}
