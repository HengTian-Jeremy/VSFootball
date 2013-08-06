package models

type Turn struct{
	Id int64
	Gameid int64
	Player1id string
	Player2id string
	Previousturn int64
	Yardline int
	Down int
	Downdistance int
	Player1playselected int64
	Player2playselected int64
	Player1role string
	Player2role string
	Results string
	Playtime int
	Timeelapsedingame int
	Currentplayer1score int
	Currentplayer2score int
}