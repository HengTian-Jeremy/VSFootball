package com.engagemobile.vsfootball.bean;

public class Response {
	// status code server return
	private int statusCode;
	// entity server return
	private String content;

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
