package com.engagemobile.vsfootball.bean;

public class ModelContext {
	private static ModelContext modelContext;
	private User currentUser;

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

}
