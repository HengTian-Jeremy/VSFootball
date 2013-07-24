package com.engagemobile.vsfootball.net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;

import android.util.Log;

import com.engagemobile.vsfootball.bean.Response;

public class HttpClientUtil {
	private final static String TAG = "HttpClientUtil";
	private final static int TIME_OUT = 30000;

	/**
	 * 
	 * Use http get method to visit server, obtain the response.
	 * 
	 * @param url
	 *            web address
	 * @return status code and entity the server returns
	 */
	public static Response doGet(String url) {
		Log.i(TAG + "doGet", url);
		Response response = new Response();

		HttpParams httpParams = new BasicHttpParams();
		// set time out parameters
		HttpConnectionParams.setConnectionTimeout(httpParams, TIME_OUT);
		HttpConnectionParams.setSoTimeout(httpParams, TIME_OUT);

		DefaultHttpClient httpClient = new DefaultHttpClient(httpParams);

		HttpGet httpGet = new HttpGet(url);
		try {
			HttpResponse httpResponse = httpClient.execute(httpGet);
			Log.i(TAG + "_responseStatusLine", httpResponse.getStatusLine().toString());
			response.setStatusCode(httpResponse.getStatusLine().getStatusCode());
			if (response.getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity entity = httpResponse.getEntity();
				if (entity != null) {
					InputStream instream = entity.getContent();
					response.setContent(convertStreamToString(instream));
					Log.i(TAG + "_responseEntity", response.getContent());
					instream.close();
				}
			}
		} catch (IOException e) {
			Log.e(TAG, "IOException", e);

		}
		return response;
	}

	/**
	 * 
	 * @Description: Use http post method to visit server, obtain the response.
	 * 
	 * @param url
	 *            web address
	 * @param content
	 *            post data, use json type
	 * @return status code and entity the server returns
	 */
	public static Response doPost(String url, String content) {
		Log.i(TAG + "_doPost_auth", url + "?" + content);
		Response response = new Response();

		HttpParams httpParams = new BasicHttpParams();
		// set time out parameters
		HttpConnectionParams.setConnectionTimeout(httpParams, TIME_OUT);
		HttpConnectionParams.setSoTimeout(httpParams, TIME_OUT);

		DefaultHttpClient httpClient = new DefaultHttpClient(httpParams);

		HttpPost httpPost = new HttpPost(url);
		try {
			// set post data parameters
			StringEntity stringEntity = new StringEntity(content, HTTP.UTF_8);
			stringEntity.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE,
					"application/json"));
			stringEntity.setContentEncoding(new BasicHeader(HTTP.CONTENT_LEN,
					String.valueOf(content.length())));
			httpPost.setEntity(stringEntity);

			HttpResponse httpResponse = httpClient.execute(httpPost);
			Log.i(TAG + "_responseStatusLine", httpResponse.getStatusLine()
					.toString());
			response.setStatusCode(httpResponse.getStatusLine().getStatusCode());
			if (response.getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity entity = httpResponse.getEntity();
				if (entity != null) {
					InputStream instream = entity.getContent();
					response.setContent(convertStreamToString(instream));
					Log.i(TAG + "_responseEntity", response.getContent());
					instream.close();
				}
			}
		} catch (IOException e) {
			Log.e(TAG, "IOException", e);
		}
		return response;
	}

	/**
	 * 
	 * @Description: Convert the InputStream to String.
	 * 
	 * @param is
	 *            inputStream
	 * @return string convert from the inputStream
	 */
	private static String convertStreamToString(InputStream is) {
		/*
		 * To convert the InputStream to String we use the
		 * BufferedReader.readLine() method. We iterate until the BufferedReader
		 * return null which means there's no more data to read. Each line will
		 * appended to a StringBuilder and returned as String.
		 */
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();

		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				sb.append(line + "\n");
			}
			is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
}
