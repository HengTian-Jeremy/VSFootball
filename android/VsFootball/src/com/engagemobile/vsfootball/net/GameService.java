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

public class GameService {
	private static final String TAG = "UserService";

	public Response getGames(User user) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("guid", user.getGuid()));
		Response response = HttpClientUtil.doGet(Resource.GET_GAMES, params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			UserResult result = gson.fromJson(strResult, UserResult.class);
			response.setResponseResult(result);

		}
		return response;
	};

}
