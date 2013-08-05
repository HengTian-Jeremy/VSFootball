package com.engagemobile.vsfootball.activity;

import java.util.Timer;
import java.util.TimerTask;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import com.engagemobile.vsfootball.natives.*;

import com.engagemobile.vsfootball.R;

public class SplashActivity extends Activity {
	private Context mContext;
	private static SplashActivity instance;
	
	static {
		System.loadLibrary("vsfootball");
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_splash);
		mContext = this;
		instance = this;
		TimerTask task = new TimerTask() {
			public void run() {
				//execute the task 
				startActivity(new Intent(mContext, LoginActivity.class));
			}
		};

		Timer timer = new Timer();
		timer.schedule(task, 1000);
		
		Core.LibMain(new String[] {}, mContext.getResources().getAssets());
		Core.start();
	}

	public static SplashActivity getInstance() {
		return instance;
	}
}
