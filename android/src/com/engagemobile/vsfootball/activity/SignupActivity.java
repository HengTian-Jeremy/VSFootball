package com.engagemobile.vsfootball.activity;

import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpStatus;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Response;
import com.engagemobile.vsfootball.net.UserService;
import com.engagemobile.vsfootball.utils.SHAUtil;
import com.engagemobile.vsfootball.utils.ValidateUtil;

public class SignupActivity extends VsFootballActivity {
	private EditText mEtEmail;
	private EditText mEtPassword;
	private EditText mEtConfirm;
	private EditText mEtFirstname;
	private EditText mEtLastname;
	private Button mBtnJoin;
	private Context mContext;
	private ProgressDialog mProgress;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_regist);
		mContext = this;
		initView();
	}

	private void initView() {
		mEtEmail = (EditText) findViewById(R.id.et_email);
		mEtPassword = (EditText) findViewById(R.id.et_password);
		mEtConfirm = (EditText) findViewById(R.id.et_confirm);
		mEtFirstname = (EditText) findViewById(R.id.et_firstname);
		mEtLastname = (EditText) findViewById(R.id.et_lastname);
		mBtnJoin = (Button) findViewById(R.id.btn_join);
		mBtnJoin.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (validateInput()) {
					handleSignup();
				}
			}
		});
	}

	/**
	 * @Description: Check info user input whether missing or not.
	 * @return true for whole user info, false for missing something
	 */
	private boolean validateInput() {
		if (mEtFirstname.getText().toString().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_firstname_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtLastname.getText().toString().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_lastname_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtEmail.getText().toString().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_email_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (!ValidateUtil.validateEmail(mEtEmail.getText().toString())) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_email_error, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtPassword.getText().toString().trim().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_password_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtConfirm.getText().toString().trim().equals("")) {
			Toast.makeText(SignupActivity.this, R.string.password_not_match,
					Toast.LENGTH_SHORT).show();
			return false;
		} else if (!mEtPassword.getText().toString()
				.equals(mEtConfirm.getText().toString())) {
			Toast.makeText(SignupActivity.this, R.string.password_not_match,
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
		AsyncTask<String, Integer, Response> signupTask = new AsyncTask<String, Integer, Response>() {

			@Override
			protected void onPreExecute() {
				if (mProgress == null) {
					mProgress = new ProgressDialog(mContext);
				}
				mProgress.setTitle(R.string.processing);
				mProgress.setMessage(getString(R.string.process_login));
				mProgress.show();
			}

			@Override
			protected Response doInBackground(String... params) {
				// TODO using REST framework instead
				UserService service = new UserService();
				String email = mEtEmail.getText().toString();
				String password = "";
				try {
					password = SHAUtil.getSHA(mEtPassword.getText().toString());
				} catch (NoSuchAlgorithmException e) {
					return null;
				}
				String firstName = mEtFirstname.getText().toString();
				String lastName = mEtLastname.getText().toString();
				return service.signup(email, password, firstName, lastName);
			}

			@Override
			protected void onPostExecute(Response result) {
				mProgress.dismiss();
				if (result != null && result.getStatusCode() == HttpStatus.SC_OK) {
					// TODO
					Toast.makeText(mContext, result.getContent(), Toast.LENGTH_SHORT).show();
				} else {
					Toast.makeText(mContext, "Login Failed!", Toast.LENGTH_SHORT).show();
				}
			}

		};
		signupTask.execute(new String[] {});
	}
}
