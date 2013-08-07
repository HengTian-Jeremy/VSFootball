package com.engagemobile.vsfootball.net;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.net.bean.ResponseResult;
import com.google.gson.Gson;

public class FeedbackService {
	public Response sendFeedback(String guid, String comment, String gameId,
			String screen) throws NetException {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("guid", guid));
		params.add(new BasicNameValuePair("comment", comment));
		Response response = HttpClientUtil.doPost(Resource.FEED_BACK, params);

		if (response.getStatusCode() == HttpStatus.SC_OK) {
			// get user info success
			String strResult = response.getContent();
			Gson gson = new Gson();
			ResponseResult result = gson.fromJson(strResult,
					ResponseResult.class);
			response.setResponseResult(result);
		}
		return response;
	};
}
