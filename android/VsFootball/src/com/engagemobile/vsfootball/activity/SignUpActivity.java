package com.engagemobile.vsfootball.activity;

import java.security.NoSuchAlgorithmException;

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
import com.engagemobile.vsfootball.bean.User;
import com.engagemobile.vsfootball.integration.FlurryEventId;
import com.engagemobile.vsfootball.integration.FlurryLogEvent;
import com.engagemobile.vsfootball.integration.FlurryParam;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.UserService;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.utils.SHAUtil;
import com.engagemobile.vsfootball.utils.ValidateUtil;

/**
 * The activity is for the user to sign up his account.
 * 
 * @author xiaoyuanhu
 */
public class SignUpActivity extends VsFootballActivity {
	private EditText mEtEmail;
	private EditText mEtPassword;
	private EditText mEtConfirm;
	private EditText mEtFirstname;
	private EditText mEtLastname;
	private Button mBtnSignUp;
	private Button mBtnCancel;
	private Context mContext;
	private ProgressDialog mProgress;
	private SignUpActivity instance;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_regist);
		mContext = this;
		instance = this;
		initView();
	}

	/**
	 * he method is used to initialize all controls in this activity
	 */
	private void initView() {
		mEtEmail = (EditText) findViewById(R.id.et_email);
		mEtPassword = (EditText) findViewById(R.id.et_password);
		mEtConfirm = (EditText) findViewById(R.id.et_confirm);
		mEtFirstname = (EditText) findViewById(R.id.et_firstname);
		mEtLastname = (EditText) findViewById(R.id.et_lastname);
		mBtnSignUp = (Button) findViewById(R.id.btn_signup);
		mBtnCancel = (Button) findViewById(R.id.btn_cancel);
		mBtnSignUp.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (validateInput()) {
					handleSignup();
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
	 * @Description: Check info user input whether missing or not.
	 * @return true for whole user info, false for missing something
	 */
	private boolean validateInput() {
		if (mEtEmail.getText().toString().equals("")) {
			Toast.makeText(SignUpActivity.this,
					R.string.register_input_email_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (!ValidateUtil.validateEmail(mEtEmail.getText().toString())) {
			Toast.makeText(SignUpActivity.this,
					R.string.register_input_email_error, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtPassword.getText().toString().trim().equals("")) {
			Toast.makeText(SignUpActivity.this,
					R.string.register_input_password_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtConfirm.getText().toString().trim().equals("")) {
			Toast.makeText(SignUpActivity.this, R.string.password_not_match,
					Toast.LENGTH_SHORT).show();
			return false;
		} else if (!mEtPassword.getText().toString()
				.equals(mEtConfirm.getText().toString())) {
			Toast.makeText(SignUpActivity.this, R.string.password_not_match,
					Toast.LENGTH_SHORT).show();
			mEtPassword.setText("");
			mEtConfirm.setText("");
			mEtPassword.requestFocus();
			return false;
		} else {
			return true;
		}

	}

	public void handleSignup() {
		AsyncTask<String, Integer, Boolean> signupTask = new AsyncTask<String, Integer, Boolean>() {
			private String message;

			@Override
			protected void onPreExecute() {
				if (mProgress == null) {
					mProgress = new ProgressDialog(mContext);
				}
				mProgress.setTitle(R.string.processing);
				mProgress.setMessage(getString(R.string.process_login));
				mProgress.show();
				message = "";
			}

			@Override
			protected Boolean doInBackground(String... params) {
				// TODO using REST framework instead
				try {
					UserService service = new UserService();
					String email = mEtEmail.getText().toString();
					String password = "";
					String firstName = mEtFirstname.getText().toString();
					String lastName = mEtLastname.getText().toString();
					password = SHAUtil.getSHA(mEtPassword.getText().toString());
					User user = new User();
					user.setEmail(email);
					if (!firstName.isEmpty() && firstName != "") {
						user.setFirstName(firstName);
					}
					if (!lastName.isEmpty() && lastName != "") {
						user.setLastName(lastName);
					}
					user.setPassword(password);
					user.setPlatform(getString(R.string.platform));
					Response response = service.signup(user);
					if (!response.getResponseResult().getSuccess()) {
						message = response.getResponseResult().getMessage();
						return false;
					} else {
						FlurryLogEvent logEvent = new FlurryLogEvent(
								FlurryEventId.SIGNUP_SUCCESS);
						logEvent.addParam(FlurryParam.EMAIL, email);
						logEvent.send();
						return true;
					}

				} catch (NoSuchAlgorithmException e) {
					message = e.getMessage();
					return false;
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
					Toast.makeText(mContext, "Signup Success!",
							Toast.LENGTH_LONG).show();
					startActivity(new Intent(mContext, LoginActivity.class));
				} else {
					showAlert(getString(R.string.signup_failed), message);
					FlurryLogEvent logEvent = new FlurryLogEvent(
							FlurryEventId.SIGNUP_FAILED);
					logEvent.addParam(FlurryParam.MESSAGE, message);
					logEvent.send();
				}
			}

		};
		signupTask.execute(new String[] {});
	}
}
