package com.engagemobile.vsfootball.net;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.engagemobile.vsfootball.bean.ModelContext;
import com.engagemobile.vsfootball.bean.User;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.net.bean.UserResult;
import com.google.gson.Gson;

public class GameService {
	private static final String TAG = "UserService";

	public Response getGames(User user) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("guid", user.getGuid()));
		Response response = HttpClientUtil.doGet(Resource.GAMES, params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			UserResult result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	};

	public Response inviteToJoinByEmail(String email) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("guid", ModelContext.getInstance()
				.getGuid()));
		params.add(new BasicNameValuePair("EmailAddress", email));
		Response response = HttpClientUtil.doPost(
				Resource.INVITE_JOIN_BY_EMAIL,
				params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			UserResult result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	}

	public Response createGame(String inviteEmail, String possession,
			String teamName, String playIdSelected) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("guid", ModelContext.getInstance()
				.getGuid()));
		params.add(new BasicNameValuePair("inviteEmail", inviteEmail));
		params.add(new BasicNameValuePair("possession", inviteEmail));
		params.add(new BasicNameValuePair("teamName", inviteEmail));
		params.add(new BasicNameValuePair("playIdSelected", inviteEmail));
		Response response = HttpClientUtil.doPost(Resource.GAMES, params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			UserResult result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	}

	public Response resignGame(String gameId) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("guid", ModelContext.getInstance()
				.getGuid()));
		params.add(new BasicNameValuePair("GameId", gameId));
		Response response = HttpClientUtil.doPost(Resource.RESIGN_GAME, params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			UserResult result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	}
}
