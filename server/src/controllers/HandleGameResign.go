package controllers


import (
	"net/http"
	"fmt"
	"models"
	"github.com/gorilla/mux"
)



func HandleGameResign(res http.ResponseWriter,request *http.Request){
	vars := mux.Vars(request)
	guid := vars["guid"]

	gameid:= request.FormValue("gameId")

	if(models.ResignGame(guid,gameid)){
		fmt.Fprintf(res,"success")	
	} else{
		fmt.Fprintf(res,"false")
	}
	


}