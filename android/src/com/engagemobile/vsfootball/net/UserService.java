package com.engagemobile.vsfootball.net;

import org.apache.http.HttpStatus;

import android.util.Log;

import com.engagemobile.vsfootball.bean.Response;
import com.engagemobile.vsfootball.bean.User;

public class UserService {

	private static final String TAG = "UserService";

	// TODO hard coded url, remove this after Rest framewrok is implemented
	private static String LOGIN_URL = "http://vsf001.engagemobile.com/login";
	private static String SIGNUP_URL = "http://vsf001.engagemobile.com/signup";

	public int login(User user) {
		// TODO hard coded url
		Response response = HttpClientUtil.doPost(LOGIN_URL, "username=zxj&password=123");
		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String result = response.getContent();
			Log.d(TAG, "Login result:" + result);

		}
		return response.getStatusCode();
	};

	public int signup(String email, String password, String firstName, String lastName) {
		// TODO hard coded url
		Response response = HttpClientUtil.doPost(SIGNUP_URL, "email=zxjzerg@gmail.com&password=testing&firstname=Andrew&lastname=Zhao");
		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String result = response.getContent();
			Log.d(TAG, "Login result:" + result);

		}
		return response.getStatusCode();
	};
}
