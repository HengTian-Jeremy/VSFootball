package com.engagemobile.vsfootball.net.bean;

import java.util.List;

import com.engagemobile.vsfootball.bean.Game;
import com.google.gson.annotations.SerializedName;

public class GameListResult extends ResponseResult {
	@SerializedName("Games") private List<Game> games;

	public List<Game> getGames() {
		return games;
	}

	public void setGames(List<Game> games) {
		this.games = games;
	}

}
