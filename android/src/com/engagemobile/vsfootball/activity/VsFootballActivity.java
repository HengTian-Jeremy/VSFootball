package com.engagemobile.vsfootball.activity;

import android.app.Activity;
import android.app.AlertDialog;
import android.os.Bundle;
import android.view.Menu;

import com.engagemobile.vsfootball.R;
import com.flurry.android.FlurryAgent;

public class VsFootballActivity extends Activity {

	private AlertDialog mAlertDialog;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_vs_football);
	}

	@Override
	protected void onStart() {
		// TODO Auto-generated method stub
		FlurryAgent.setContinueSessionMillis(1000);
		FlurryAgent.onStartSession(this, "J87QSPCGD484RV66QSF4");
		super.onStart();
	}

	@Override
	protected void onStop() {
		// TODO Auto-generated method stub
		FlurryAgent.onEndSession(this);
		super.onStop();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.vs_football, menu);
		return true;
	}

	public void showAlert(String title, String msg) {
		if (mAlertDialog == null) {
			mAlertDialog = new AlertDialog.Builder(this).create();
		}
		mAlertDialog.setTitle(title);
		mAlertDialog.setMessage(msg);
		mAlertDialog.setCancelable(true);
		mAlertDialog.setCanceledOnTouchOutside(true);
		mAlertDialog.show();
	}

	public void dismissAlert() {
		if (mAlertDialog != null) {
			mAlertDialog.dismiss();
		}
	}
}
