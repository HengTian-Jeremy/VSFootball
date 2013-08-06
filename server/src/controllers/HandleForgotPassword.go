package controllers

import (
	"net/http"
	"encoding/json"
	"fmt"
	"models"
	"jsonOutputs"	
)
func HandleForgotPassword(res http.ResponseWriter,request *http.Request){
	email := request.FormValue("email")
	output := jsonOutputs.SuccessMessage{"false","Account does not exist."}
	emailLen := len(email)
	if(0 < emailLen && emailLen <100){
		if(models.ForgotPassword(email)){
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