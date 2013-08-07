package com.engagemobile.vsfootball.net;

public enum Resource {
	LOGIN("/user/login"),
	SIGNUP("/user/signup"),
	SEND_EMAIL_NOTIFICATION("/user/sendemailnotification"),
	FORGOT_PASSWORD("/user/forgotpassword"),
	GAMES("/{guid}/games"),
	FEED_BACK("/{guid}/feedback"),
	INVITE_JOIN_BY_EMAIL("/{guid}/invite/email"),
	RESIGN_GAME("/{guid}/games/resign");

	private String path;

	Resource(String path) {
		this.path = path;
	}

	public String getPath() {
		return path;
	}
}
