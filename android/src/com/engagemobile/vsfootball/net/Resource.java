package com.engagemobile.vsfootball.net;

public enum Resource {
	LOGIN("/login"),
	SIGNUP("/signup");

	private String path;

	Resource(String path) {
		this.path = path;
	}

	public String getPath() {
		return path;
	}
}
