package controllers

import (
	"net/http"
	"fmt"
	"encoding/json"
	"jsonOutputs"
	"models"
)


func HandleLogin (res http.ResponseWriter,request *http.Request){
	username := request.FormValue("username")
	password := request.FormValue("password")
	
	output := jsonOutputs.LoginOutput{"false","Invalid Username/Password or Account Does Not Exist.","null"}
	usernameLen := len(username)
	if(0 < usernameLen && usernameLen < 100){
		passwordLen := len(password)
		if(0 < passwordLen && passwordLen <= 40	){
			guid,loginErr,message := models.AccountLogin(username,password)	
			if(loginErr == nil){
				if(guid != ""){
					if(message == 0){
						output = jsonOutputs.LoginOutput{"false","Account has not been verified.",""}
					} else {
						output = jsonOutputs.LoginOutput{"true","Successful login.",guid}																
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