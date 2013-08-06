package models

type Game struct{
	Id int64
	Created int64
	Player1 string
	Player2 string
	Player1teamname string
	Player2teamname string
	Outcome string
	Player1accepteddate int64
	Player2accepteddate int64
	Enddate int64
	Inviteaccepted int64
}