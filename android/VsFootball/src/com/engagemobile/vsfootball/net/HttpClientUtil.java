package com.engagemobile.vsfootball.net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
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

import com.engagemobile.vsfootball.net.bean.Response;

public class HttpClientUtil {
	private final static String TAG = "HttpClientUtil";
	private final static int TIME_OUT = 30000;
	private static String SERVER_URL = "http://vsf001.engagemobile.com";

	/**
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
	 * @Description: Use http post method to visit server, obtain the response.
	 * @param url
	 *            web address
	 * @param content
	 *            post data, use json type
	 * @return status code and entity the server returns
	 * @throws NetException
	 */
	public static Response doPost(String url, List<NameValuePair> params)
			throws NetException {
		Log.i(TAG + "do post", url);
		Response response = new Response();

		HttpParams httpParams = new BasicHttpParams();
		// set time out parameters
		HttpConnectionParams.setConnectionTimeout(httpParams, TIME_OUT);
		HttpConnectionParams.setSoTimeout(httpParams, TIME_OUT);
		DefaultHttpClient httpClient = new DefaultHttpClient(httpParams);

		try {
			HttpPost httpPost = new HttpPost(url);
			httpPost.setEntity(new UrlEncodedFormEntity(params));

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
			} else {
				throw new NetException("Negative response from server. "
						+ httpResponse.getStatusLine()
								.toString());
			}
		} catch (IOException e) {
			Log.e(TAG, "IOException", e);
			throw new NetException(e);
		}
		return response;
	}

	/**
	 * Use http get method to visit server, obtain the response.
	 * 
	 * @param url
	 *            web address
	 * @return status code and entity the server returns
	 */
	public static Response doGet(Resource resource, List<NameValuePair> params) {
		String url = generateUrl(resource, params);
		Response response = new Response();

		HttpParams httpParams = new BasicHttpParams();
		// set time out parameters
		HttpConnectionParams.setConnectionTimeout(httpParams, TIME_OUT);
		HttpConnectionParams.setSoTimeout(httpParams, TIME_OUT);

		DefaultHttpClient httpClient = new DefaultHttpClient(httpParams);

		HttpGet httpGet = new HttpGet(url);
		try {
			HttpResponse httpResponse = httpClient.execute(httpGet);
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
	 * @Description: Use http post method to visit server, obtain the response.
	 * @param url
	 *            web address
	 * @param content
	 *            post data, use json type
	 * @return status code and entity the server returns
	 * @throws NetException
	 */
	public static Response doPost(Resource resource, List<NameValuePair> params)
			throws NetException {
		String url = generateUrl(resource, params);
		Response response = new Response();

		HttpParams httpParams = new BasicHttpParams();
		// set time out parameters
		HttpConnectionParams.setConnectionTimeout(httpParams, TIME_OUT);
		HttpConnectionParams.setSoTimeout(httpParams, TIME_OUT);
		DefaultHttpClient httpClient = new DefaultHttpClient(httpParams);

		try {
			HttpPost httpPost = new HttpPost(url);
			httpPost.setEntity(new UrlEncodedFormEntity(params));

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
			} else {
				throw new NetException("Negative response from server. "
						+ httpResponse.getStatusLine()
								.toString());
			}
		} catch (IOException e) {
			Log.e(TAG, "IOException", e);
			throw new NetException(e);
		}
		return response;
	}

	/**
	 * @Description: Convert the InputStream to String.
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

	private static String generateUrl(Resource resource,
			List<NameValuePair> params) {
		String url = SERVER_URL + resource.getPath();
		for (NameValuePair nvp : params) {
			String value = "";
			if (nvp.getName() != null && nvp.getValue() == null) {
				value = "";
			}
			else {
				value = nvp.getValue();
			}
			url = url.replace("{" + nvp.getName() + "}",
					value);
		}
		Log.d(TAG, "URL:" + url);
		return url;
	}
}
