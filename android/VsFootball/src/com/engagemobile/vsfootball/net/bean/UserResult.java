package com.engagemobile.vsfootball.net.bean;

import com.google.gson.annotations.SerializedName;

public class UserResult extends ResponseResult {
	@SerializedName("Guid") private String guid;

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

}
