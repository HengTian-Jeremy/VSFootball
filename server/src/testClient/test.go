package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
	"net/url"
	"time"
	    // "crypto/sha1"
	// "encoding/base64"
)

func main(){
	fmt.Println("signup test")

	fmt.Println(time.Now())
	values := make(url.Values)
	values.Set("email","rpmd30@gmail.com")
	values.Set("firstname","rpmd30@gmail.com")
	values.Set("lastname","rpmd30@gmail.com")
	values.Set("password","rpmd30@gmail.com")
	myclient , err := http.PostForm("http://vsf001.engagemobile.com/user/signup",values)

	if(err != nil){
		fmt.Println(string(err.Error()))	
	} else{
		body, err := ioutil.ReadAll(myclient.Body)	
		myclient.Body.Close()
		if(err != nil){
			fmt.Println(string(err.Error()))	
		} else {
			fmt.Println(string(body))
		}
	}
	fmt.Println(time.Now())
	fmt.Println("login test")


	values2 := make(url.Values)
	values2.Set("username","rpmd30@gmail.com")
	            // hasher := sha1.New()
            // hasher.Write([]byte("ZW5nYWdlbW9iaWxlMTIz"))
            // sha1output := base64.URLEncoding.EncodeToString(hasher.Sum(nil))
	values2.Set("password","")
	myclient2, loginErr := http.PostForm("http://localhost:8080/user/login",values2)
	if(loginErr != nil){
		fmt.Println(string(loginErr.Error()))	
	} else{
		body, err := ioutil.ReadAll(myclient2.Body)	
		myclient2.Body.Close()
		if(err != nil){
			fmt.Println(string(loginErr.Error()))	
		} else {
			fmt.Println(string(body))
		}
	}

	// fmt.Println("verify test")
	// query := "http://vsf001.engagemobile.com/2d1b87d995ba43e27530735d54a04a9f/verify"
	// myclient3,err := http.Get(query)
	// fmt.Println(err)
	// body,_ :=ioutil.ReadAll(myclient3.Body)
	// myclient3.Body.Close()
	// fmt.Println(body)

	// fmt.Println("resend email test")
	// query2 := "http://vsf001.engagemobile.com/user/sendemailnotification"
	// values4 := make(url.Values)
	// values4.Set("email","rpmd30@gmail.com")
	// myclient4,_ := http.PostForm(query2,values4)
	// body2 ,_ := ioutil.ReadAll(myclient4.Body)
	// myclient4.Body.Close()
	// fmt.Println(body2)
	
	// fmt.Println("forgot email test")
	// query2 = "http://localhost:8080/user/forgotpassword"
	// values4 = make(url.Values)
	// values4.Set("email","rpmd30@gmail.com")
	// myclient4,_ = http.PostForm(query2,values4)
	// body2 ,_ = ioutil.ReadAll(myclient4.Body)
	// myclient4.Body.Close()
	// fmt.Println(body2)

	query6 := "http://localhost:8080/2d1b87d995ba43e27530735d54a04a9f/feedback"
	values6 := make(url.Values)
	values6.Set("comment","my cool comments")
	values6.Set("gameid","some game id")
	myclient6, _ := http.PostForm(query6,values6)
	body6 ,_ := ioutil.ReadAll(myclient6.Body)
	myclient6.Body.Close()
	fmt.Println(body6)


}
