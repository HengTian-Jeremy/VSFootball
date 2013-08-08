package com.engagemobile.vsfootball.bean;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Turn {
	@Expose @SerializedName("Id") private int id;
	@Expose @SerializedName("Player1id") private String player1Id;
	@Expose @SerializedName("Player2id") private String player2Id;
	@Expose @SerializedName("Previousturn") private int previousTurn;
	@Expose @SerializedName("Yardline") private int yardLine;
	@Expose @SerializedName("Down") private int down;
	@Expose @SerializedName("Downdistance") private int downDistance;
	@Expose @SerializedName("Player1playselected") private int player1PlaySelected;
	@Expose @SerializedName("Player2playselected") private int player2PlaySelected;
	@Expose @SerializedName("Player1role") private String player1Role;
	@Expose @SerializedName("Player2role") private String player2Role;
	@Expose @SerializedName("Results") private String results;
	@Expose @SerializedName("Playtime") private long playTime;
	@Expose @SerializedName("Timeelapsedingame") private long timeElapsedInGame;
	@Expose @SerializedName("Currentplayer1score") private int currentPlayer1Score;
	@Expose @SerializedName("Currentplayer2score") private int currentPlayer2Score;

	public Turn() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPlayer1Id() {
		return player1Id;
	}

	public void setPlayer1Id(String player1Id) {
		this.player1Id = player1Id;
	}

	public String getPlayer2Id() {
		return player2Id;
	}

	public void setPlayer2Id(String player2Id) {
		this.player2Id = player2Id;
	}

	public int getPreviousTurn() {
		return previousTurn;
	}

	public void setPreviousTurn(int previousTurn) {
		this.previousTurn = previousTurn;
	}

	public int getYardLine() {
		return yardLine;
	}

	public void setYardLine(int yardLine) {
		this.yardLine = yardLine;
	}

	public int getDown() {
		return down;
	}

	public void setDown(int down) {
		this.down = down;
	}

	public int getDownDistance() {
		return downDistance;
	}

	public void setDownDistance(int downDistance) {
		this.downDistance = downDistance;
	}

	public int getPlayer1PlaySelected() {
		return player1PlaySelected;
	}

	public void setPlayer1PlaySelected(int player1PlaySelected) {
		this.player1PlaySelected = player1PlaySelected;
	}

	public int getPlayer2PlaySelected() {
		return player2PlaySelected;
	}

	public void setPlayer2PlaySelected(int player2PlaySelected) {
		this.player2PlaySelected = player2PlaySelected;
	}

	public String getPlayer1Role() {
		return player1Role;
	}

	public void setPlayer1Role(String player1Role) {
		this.player1Role = player1Role;
	}

	public String getPlayer2Role() {
		return player2Role;
	}

	public void setPlayer2Role(String player2Role) {
		this.player2Role = player2Role;
	}

	public String getResults() {
		return results;
	}

	public void setResults(String results) {
		this.results = results;
	}

	public long getPlayTime() {
		return playTime;
	}

	public void setPlayTime(long playTime) {
		this.playTime = playTime;
	}

	public long getTimeElapsedInGame() {
		return timeElapsedInGame;
	}

	public void setTimeElapsedInGame(long timeElapsedInGame) {
		this.timeElapsedInGame = timeElapsedInGame;
	}

	public int getCurrentPlayer1Score() {
		return currentPlayer1Score;
	}

	public void setCurrentPlayer1Score(int currentPlayer1Score) {
		this.currentPlayer1Score = currentPlayer1Score;
	}

	public int getCurrentPlayer2Score() {
		return currentPlayer2Score;
	}

	public void setCurrentPlayer2Score(int currentPlayer2Score) {
		this.currentPlayer2Score = currentPlayer2Score;
	}

}
