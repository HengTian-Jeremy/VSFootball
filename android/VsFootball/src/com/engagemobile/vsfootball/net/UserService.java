package com.engagemobile.vsfootball.net;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.engagemobile.vsfootball.bean.User;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.net.bean.UserResult;
import com.google.gson.Gson;

public class UserService {

	private static final String TAG = "UserService";

	private static String SERVER_URL = "http://vsf001.engagemobile.com";

	public Response login(User user) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("username", user.getUsername()));
		params.add(new BasicNameValuePair("password", user.getPassword()));
		Response response = HttpClientUtil.doPost(
				SERVER_URL + Resource.LOGIN.getPath(), params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			UserResult result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	};

	public Response signup(User user) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("email", user.getEmail()));
		params.add(new BasicNameValuePair("firstname", user.getFirstName()));
		params.add(new BasicNameValuePair("lastname", user.getLastName()));
		params.add(new BasicNameValuePair("password", user.getPassword()));
		params.add(new BasicNameValuePair("platform", user.getPlatform()));
		Response response = HttpClientUtil.doPost(
				SERVER_URL + Resource.SIGNUP.getPath(), params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			UserResult result;
			Gson gson = new Gson();
			result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	};

	public Response sendEmailVerification(String email) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("email", email));
		Response response = HttpClientUtil.doPost(SERVER_URL
				+ Resource.SEND_EMAIL_NOTIFICATION.getPath(), params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			UserResult result;
			Gson gson = new Gson();
			result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	};

	public Response forgotPassword(String email) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("email", email));
		Response response = HttpClientUtil.doPost(SERVER_URL
				+ Resource.FORGOT_PASSWORD.getPath(), params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			UserResult result;
			Gson gson = new Gson();
			result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	};

}
