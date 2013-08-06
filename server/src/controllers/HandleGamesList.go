package controllers


import (
	"net/http"
	"models"
	"github.com/gorilla/mux"
	"fmt"
	"jsonOutputs"
	"encoding/json"
)


func HandleGamesList(res http.ResponseWriter,request *http.Request){
	vars := mux.Vars(request)
	guid := vars["guid"]
	success,message,results := models.GamesList(guid)
	outputJson,_ :=json.Marshal(jsonOutputs.GameListOutput{"false","",nil})
	if(success){
		outputJson,_ =json.Marshal(jsonOutputs.GameListOutput{Success:"true",Message:message,Games:results})	
	} else {
		outputJson,_ =json.Marshal(jsonOutputs.GameListOutput{Success:"false",Message:message,Games:results})	
	}
	
	fmt.Fprintf(res,string(outputJson))
}