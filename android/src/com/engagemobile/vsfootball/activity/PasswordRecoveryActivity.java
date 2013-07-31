package com.engagemobile.vsfootball.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.integration.FlurryEventId;
import com.engagemobile.vsfootball.integration.FlurryLogEvent;
import com.engagemobile.vsfootball.integration.FlurryParam;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.UserService;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.utils.ValidateUtil;

/**
 * The activity is used for the user who is forget his password.
 * 
 * @author xiaoyuanhu
 */
public class PasswordRecoveryActivity extends VsFootballActivity {
	private EditText mEtEmail;
	private Button mBtnSubmit;
	private Button mBtnCancel;
	private ProgressDialog mProgress;
	private Context mContext;
	private PasswordRecoveryActivity instance;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_password_recovery);
		mContext = this;
		instance = this;
		mEtEmail = (EditText) findViewById(R.id.et_input_email);
		mBtnSubmit = (Button) findViewById(R.id.btn_submit);
		mBtnCancel = (Button) findViewById(R.id.btn_cancel);
		mBtnSubmit.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (validateInput()) {
					handleSendEmail();
				}
			}
		});
		mBtnCancel.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				instance.finish();
			}
		});
	}

	/**
	 * @Description: Check info email input whether missing or not.
	 * @return true for whole email info, false for missing something
	 */
	private boolean validateInput() {
		if (mEtEmail.getText().toString().equals("")) {
			Toast.makeText(PasswordRecoveryActivity.this,
					R.string.register_input_email_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (!ValidateUtil.validateEmail(mEtEmail.getText().toString())) {
			Toast.makeText(PasswordRecoveryActivity.this,
					R.string.register_input_email_error, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else {
			return true;
		}
	}

	/**
	 * Handle the send email request
	 */
	public void handleSendEmail() {
		AsyncTask<String, Integer, Boolean> signupTask = new AsyncTask<String, Integer, Boolean>() {
			private String message;

			@Override
			protected void onPreExecute() {
				if (mProgress == null) {
					mProgress = new ProgressDialog(mContext);
				}
				mProgress.setTitle(R.string.processing);
				mProgress.setMessage(getString(R.string.process_sending));
				mProgress.show();
				message = "";
			}

			@Override
			protected Boolean doInBackground(String... params) {
				// TODO using REST framework instead
				try {
					UserService service = new UserService();
					String email = mEtEmail.getText().toString();
					Response response = service.forgotPassword(email);
					if (!response.getResponseResult().getSuccess()) {
						message = response.getResponseResult().getMessage();
						return false;
					} else {
						FlurryLogEvent logEvent = new FlurryLogEvent(
								FlurryEventId.SEND_EMAIL_SUCCESS);
						logEvent.addParam(FlurryParam.EMAIL, email);
						logEvent.send();
						return true;
					}

				} catch (NetException e) {
					message = e.getMessage();
					return false;
				}

			}

			@Override
			protected void onPostExecute(Boolean result) {
				mProgress.dismiss();
				if (result == true) {
					// TODO
					Toast.makeText(mContext, "Send success!",
							Toast.LENGTH_LONG).show();
					startActivity(new Intent(mContext, LoginActivity.class));
				} else {
					showAlert(getString(R.string.signup_failed), message);
					FlurryLogEvent logEvent = new FlurryLogEvent(
							FlurryEventId.SEND_EMAIL_FAILED);
					logEvent.addParam(FlurryParam.MESSAGE, message);
					logEvent.send();
				}
			}

		};
		signupTask.execute(new String[] {});
	}
}
