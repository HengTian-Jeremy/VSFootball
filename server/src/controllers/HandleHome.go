package controllers

import (
	"fmt"
	"net/http"
)

func HandleHome(res http.ResponseWriter, request *http.Request) {
	fmt.Fprintf(res,"Powered by Go.")
}