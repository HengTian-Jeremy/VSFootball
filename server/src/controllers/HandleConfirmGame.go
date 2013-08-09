package controllers

import(
	"net/http"
	"models"
	"github.com/gorilla/mux"
	"fmt"
	"jsonOutputs"
	"encoding/json"
)

func HandleConfirmGame (res http.ResponseWriter,request *http.Request){
	vars := mux.Vars(request)
	guid := vars["guid"]

	gameid := request.FormValue("gameid")

	results := models.ConfirmGame(guid,gameid)

	var output jsonOutputs.SuccessMessage
	if(results){
		output = jsonOutputs.SuccessMessage{"true","Game has been confirmed"}
	} else {
		output = jsonOutputs.SuccessMessage{"false","Game was not confirmed"}
	}
	jsonOutput,_ := json.Marshal(output)
	fmt.Fprintf(res,string(jsonOutput))
}