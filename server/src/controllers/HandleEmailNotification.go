package controllers

import (
	"net/http"
	"fmt"
	"encoding/json"
	"models"
	"jsonOutputs"
)


func HandleEmailNotification(res http.ResponseWriter,request *http.Request){
	email := request.FormValue("email")
	output := jsonOutputs.SuccessMessage{"false","Account has not been created."}
	emailLen := len(email)
	if(0 < emailLen && emailLen <100){
		if(models.SendEmailVerification(email)){
			output = jsonOutputs.SuccessMessage{"true","Email verification has been sent."}	
		}
	}
	outputJson,err :=json.Marshal(output)
	if(err == nil){
		fmt.Fprintf(res,string(outputJson))	
	} else{
		fmt.Fprintf(res,err.Error())
	}
}