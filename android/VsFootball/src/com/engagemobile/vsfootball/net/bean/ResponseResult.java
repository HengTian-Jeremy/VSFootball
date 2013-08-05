package com.engagemobile.vsfootball.net.bean;

import com.google.gson.annotations.SerializedName;

public class ResponseResult {
	@SerializedName("Success") private Boolean success;
	@SerializedName("Message") private String message;

	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
