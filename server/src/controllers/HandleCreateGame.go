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

	results,success,gameid := models.CreateGame(guid,inviteEmail,possession,teamName,playIdSelected)
	var output jsonOutputs.GameOutput
	if(success){
		output = jsonOutputs.GameOutput{Success:"true",Message:results,Gameid:gameid}
	} else {
		output = jsonOutputs.GameOutput{Success:"false",Message:results,Gameid:gameid}
	}
	outputJson,_ :=json.Marshal(output)
	fmt.Fprintf(res,string(outputJson))	
	fmt.Println("createGame")

}