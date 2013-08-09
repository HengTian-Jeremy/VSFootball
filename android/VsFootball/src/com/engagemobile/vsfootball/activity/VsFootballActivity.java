package com.engagemobile.vsfootball.activity;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import com.engagemobile.vsfootball.R;
import com.flurry.android.FlurryAgent;

/**
 * This is a Superclass inherits from activity, All other classes inherit from
 * this activity ,It manages Android Activity life cycle methods.
 * 
 * @author xiaoyuanhu
 */
public class VsFootballActivity extends Activity {
	private static final String TAG = "VsFootballActivity";

	private AlertDialog mAlertDialog;
	private ProgressDialog mProgressDialog;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		// setContentView(R.layout.activity_vs_football);
	}

	@Override
	protected void onStop() {
		FlurryAgent.onEndSession(this);
		super.onStop();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu,this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.vs_football, menu);
		return true;
	}

	/**
	 * Display warning information.
	 * 
	 * @param title
	 *            Set title of the dialog.
	 * @param msg
	 *            Set the message of the dialog.
	 */
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

	/**
	 * Dismiss warning information.
	 */
	public void dismissAlert() {
		if (mAlertDialog != null) {
			mAlertDialog.dismiss();
		}
	}

	/**
	 * Create and show a {@link ProgressDialog}
	 * 
	 * @param titleId
	 *            The resource id of title for the dialog.
	 * @param msgId
	 *            The resource id of message to display in the dialog content.
	 */
	public void showProgress(int titleId, int msgId) {
		if (mProgressDialog == null) {
			mProgressDialog = new ProgressDialog(this);
		}
		mProgressDialog.setTitle(getString(titleId));
		mProgressDialog.setMessage(getString(msgId));
		mProgressDialog.show();
	}

	public void dismissProgress() {
		if (mProgressDialog != null) {
			mProgressDialog.dismiss();
		}
	}

	/**
	 * Dissmiss the showing progress dialog
	 * 
	 * @param millis
	 *            The time to wait before dismiss the dialog in milliseconds
	 */
	public void dissmissProgress(long millis) {
		if (millis > 0) {
			try {
				synchronized (this) {
					wait(millis);
				}
			} catch (InterruptedException ex) {
				dismissProgress();
				Log.e(TAG, "Error of dissmiss progress", ex);
			}
		}

		dismissProgress();
	}

}
