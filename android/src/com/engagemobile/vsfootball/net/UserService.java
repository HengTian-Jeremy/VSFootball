package com.engagemobile.vsfootball.net;

import org.apache.http.HttpStatus;

import android.util.Log;

import com.engagemobile.vsfootball.bean.Response;

public class UserService {

	private static final String TAG = "UserService";

	// TODO hard coded url, remove this after Rest framewrok is implemented
	private static String LOGIN_URL = "http://vsf001.engagemobile.com/login";
	private static String SIGNUP_URL = "http://vsf001.engagemobile.com/signup";

	public Response login(String username, String password) {
		// TODO hard coded url
		Response response = HttpClientUtil.doPost(LOGIN_URL, "username=" + username + "&password=" + password);
		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String result = response.getContent();
			Log.d(TAG, "Login result:" + result);

		}
		return response;
	};

	public Response signup(String email, String password, String firstName, String lastName) {
		// TODO hard coded url
		Response response = HttpClientUtil.doPost(SIGNUP_URL, "email=" + email + "&password=" + password + "&firstname=" + firstName + "&lastname=" + lastName);
		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String result = response.getContent();
			Log.d(TAG, "Login result:" + result);

		}
		return response;
	};
}
