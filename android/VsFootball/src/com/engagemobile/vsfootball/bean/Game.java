package com.engagemobile.vsfootball.bean;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Game {
	@Expose @SerializedName("Gameid") private int gameId;
	@Expose @SerializedName("Player1") private String player1;
	@Expose @SerializedName("Player2") private String player2;
	@Expose @SerializedName("Player1teamname") private String player1TeamName;
	@Expose @SerializedName("Player2teamname") private String player2TeamName;
	@Expose @SerializedName("Outcome") private String outcome;
	@Expose @SerializedName("Inviteaccepted") private int inviteAccepted;
	@Expose @SerializedName("Turns") private List<Turn> turns;

	public Game() {
	}

	public int getGameId() {
		return gameId;
	}

	public void setGameId(int gameId) {
		this.gameId = gameId;
	}

	public String getPlayer1() {
		return player1;
	}

	public void setPlayer1(String player1) {
		this.player1 = player1;
	}

	public String getPlayer2() {
		return player2;
	}

	public void setPlayer2(String player2) {
		this.player2 = player2;
	}

	public String getPlayer1TeamName() {
		return player1TeamName;
	}

	public void setPlayer1TeamName(String player1TeamName) {
		this.player1TeamName = player1TeamName;
	}

	public String getPlayer2TeamName() {
		return player2TeamName;
	}

	public void setPlayer2TeamName(String player2TeamName) {
		this.player2TeamName = player2TeamName;
	}

	public String getOutcome() {
		return outcome;
	}

	public void setOutcome(String outcome) {
		this.outcome = outcome;
	}

	public int getInviteAccepted() {
		return inviteAccepted;
	}

	public void setInviteAccepted(int inviteAccepted) {
		this.inviteAccepted = inviteAccepted;
	}

	public List<Turn> getTurns() {
		return turns;
	}

	public void setTurns(List<Turn> turns) {
		this.turns = turns;
	}

}
