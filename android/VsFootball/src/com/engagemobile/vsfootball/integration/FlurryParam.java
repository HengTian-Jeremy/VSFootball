package com.engagemobile.vsfootball.integration;

/**
 * Store the parameters used when logging event to Flurry
 * 
 * @author Andrew Zhao
 */
public enum FlurryParam {
	USERNAME("username"),
	PASSWORD("password"),
	MESSAGE("message"),
	EMAIL("email"), ;

	private String mName;

	private FlurryParam(String name) {
		mName = name;
	}

	public String getName() {
		return mName;
	}
}
