package controllers


import (
	"net/http"
	"fmt"
	"models"
	"github.com/gorilla/mux"
	"encoding/json"
	"jsonOutputs"
)



func HandleGameResign(res http.ResponseWriter,request *http.Request){
	vars := mux.Vars(request)
	guid := vars["guid"]

	gameid:= request.FormValue("gameId")

	output := jsonOutputs.SuccessMessage{"false","Game resign has failed."}
	if(models.ResignGame(guid,gameid)){
		output = jsonOutputs.SuccessMessage{"true","Game resign successful."}	
	}

	outputJson,_:=json.Marshal(output)
	
	fmt.Fprintf(res,string(outputJson))	


}