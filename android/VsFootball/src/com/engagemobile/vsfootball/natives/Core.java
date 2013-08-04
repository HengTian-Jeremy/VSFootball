package com.engagemobile.vsfootball.natives;

import android.content.res.AssetManager;
import android.util.Log;

public class Core {
	public native static int LibMain(String[] argv, AssetManager mgr);
	public native static void start();
	public native static void stop();
	public static void handleSendOverHttp(int method, String URL, String payLoad) {
		Log.d("lala", "called handleSendOverHttp Method = " + method + " URL = " + URL + " payload = " + payLoad);
		return;
	}
}
