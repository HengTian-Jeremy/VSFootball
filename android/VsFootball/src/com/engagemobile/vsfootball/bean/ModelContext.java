package com.engagemobile.vsfootball.bean;

public class ModelContext {
	private static ModelContext modelContext;
	private User currentUser;
	private Game currentSelectedGame;

	private String guid;

	private ModelContext() {
		modelContext = this;
	}

	public static ModelContext getInstance() {
		if (modelContext == null) {
			return new ModelContext();
		} else {
			return modelContext;
		}
	}

	public User getCurrentUser() {
		return currentUser;
	}

	public void setCurrentUser(User currentUser) {
		this.currentUser = currentUser;
	}

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public Game getCurrentSelectedGame() {
		return currentSelectedGame;
	}

	public void setCurrentSelectedGame(Game currentSelectedGame) {
		this.currentSelectedGame = currentSelectedGame;
	}

}
