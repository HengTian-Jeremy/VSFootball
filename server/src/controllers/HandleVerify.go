package controllers

import (
	"net/http"
	"fmt"
	"models"
	"github.com/gorilla/mux"
)


func HandleVerify (res http.ResponseWriter,request *http.Request){
	vars := mux.Vars(request)
	guid := vars["guid"]
	models.VerifyAccount(guid)
	fmt.Fprintf(res,"Account has been verified.")
}