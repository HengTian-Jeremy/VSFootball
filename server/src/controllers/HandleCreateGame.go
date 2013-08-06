package controllers

import (
	"net/http"
	"models"
	"github.com/gorilla/mux"
	"fmt"
	"jsonOutputs"
	"encoding/json"
)

func HandleCreateGame (res http.ResponseWriter,request *http.Request){
	// func CreateGame(guid,inviteEmail, possession, teamName, playIdSelected string) (string,bool)
	//func CreateGame(guid,inviteEmail, possession, teamName, playIdSelected string) error,bool{
	vars := mux.Vars(request)
	guid := vars["guid"]
	inviteEmail := request.FormValue("inviteEmail")
	possession := request.FormValue("possession")
	teamName := request.FormValue("teamName")
	playIdSelected := request.FormValue("playIdSelected")

	results,success := models.CreateGame(guid,inviteEmail,possession,teamName,playIdSelected)
	var output jsonOutputs.SuccessMessage
	if(success){
		output = jsonOutputs.SuccessMessage{Success:"true",Message:results}
	} else {
		output = jsonOutputs.SuccessMessage{Success:"false",Message:results}
	}
	outputJson,_ :=json.Marshal(output)
	fmt.Fprintf(res,string(outputJson))	
	fmt.Println("createGame")

}