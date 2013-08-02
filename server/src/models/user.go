package models


type User struct {
   Id       int64
   Created  int64
   Updated  int64
   Guid     string
   Firstname string
   Lastname string
   Username string
   Password string
   Accounttype string
   Accesstoken string
   Tokenexpiration string
   Verified int
}

