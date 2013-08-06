package main

import (
	"net/http"
	"github.com/gorilla/mux"
	"controllers"
    "models"
)


func main() {
    models.Init()
    r := mux.NewRouter()
    r.HandleFunc("/",controllers.HandleHome).Methods("GET")
    r.HandleFunc("/user/signup",controllers.HandleSignUp).Methods("POST")
    r.HandleFunc("/user/login",controllers.HandleLogin).Methods("POST")
    r.HandleFunc("/user/sendemailnotification",controllers.HandleEmailNotification).Methods("POST")
    r.HandleFunc("/user/forgotpassword",controllers.HandleForgotPassword).Methods("POST")
    r.HandleFunc("/{guid}/verify",controllers.HandleVerify).Methods("GET")
    r.HandleFunc("/{guid}/feedback",controllers.HandleFeedback).Methods("POST")
    r.HandleFunc("/{guid}/games",controllers.HandleCreateGame).Methods("POST")
    r.HandleFunc("/{guid}/games",controllers.HandleGamesList).Methods("GET")
    r.HandleFunc("/{guid}/games/resign",controllers.HandleGameResign).Methods("POST")
    http.Handle("/", r)
    http.ListenAndServe(":8080",nil)
}
