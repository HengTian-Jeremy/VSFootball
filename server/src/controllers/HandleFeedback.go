package controllers

import (
	"net/http"
	"fmt"
	"encoding/json"
	"models"
	"time"
	"github.com/gorilla/mux"
	"jsonOutputs"
)


func HandleFeedback (res http.ResponseWriter,request *http.Request){
	vars := mux.Vars(request)
	guid := vars["guid"]
	
	comment:= request.FormValue("comment")
	gameid := request.FormValue("gameid")
	screen := request.FormValue("screen")
	
	output := jsonOutputs.SuccessMessage{"false","Feedback could not be added"}
	commentLen := len(comment)
	if(0 < commentLen && commentLen < 255){
		feedback :=&models.Feedback{
                    Created:time.Now().UnixNano(),
                    Comment:comment,
                    Userid:guid,
                    Gameid:gameid,
                    Screen: screen}
        if(models.AddFeedback(feedback)){
        	output =jsonOutputs.SuccessMessage{"true","Feedback was added successfully."}
        }
	}
	outputJson,err :=json.Marshal(output)
	if(err == nil){
		fmt.Fprintf(res,string(outputJson))	
	} else{
		fmt.Fprintf(res,err.Error())
	}
}