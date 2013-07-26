package com.engagemobile.vsfootball.activity;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Paint;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.User;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.UserService;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.utils.SHAUtil;
import com.flurry.android.FlurryAgent;

/**
 * This is the first screen shown when you launch this application.
 * 
 * @author xiaoyuanhu
 */
public class LoginActivity extends VsFootballActivity {
	private static final String TAG = "LoginActivity";
	private TextView mTvForgetPassword;
	private EditText mEtUsername;
	private EditText mEtPassword;
	private Button mBtnLogin;
	private Button mBtnFacebook;
	private CheckBox mChkRemember;
	private TextView mTvCreat;
	private Context mContext;
	private ProgressDialog mProgress;
	private InputMethodManager mInputManager;
	private boolean mIsRememberPassword;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_login);
		mContext = this;
		initView();
	}

	/**
	 * This method is used to initialize all controls in this activity
	 */
	private void initView() {
		mInputManager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
		mEtUsername = (EditText) findViewById(R.id.et_username);
		mEtPassword = (EditText) findViewById(R.id.et_password);
		mBtnLogin = (Button) findViewById(R.id.btn_login);
		mBtnFacebook = (Button) findViewById(R.id.btn_facebook);
		mChkRemember = (CheckBox) findViewById(R.id.cb_remember);
		mTvForgetPassword = (TextView) this.findViewById(R.id.tv_forgot);
		mTvCreat = (TextView) this.findViewById(R.id.tv_create);
		mTvForgetPassword.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG);
		mTvCreat.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG);
		final SharedPreferences userInfo = getSharedPreferences("user_info", 0);
		mIsRememberPassword = userInfo.getBoolean("isRemember", true);
		String username = userInfo.getString("username", "");
		String password = userInfo.getString("password", "");
		mEtUsername.setText(username);
		mEtPassword.setText(password);
		mChkRemember.setChecked(mIsRememberPassword);
		mChkRemember.setOnCheckedChangeListener(new OnCheckedChangeListener() {

			@Override
			public void onCheckedChanged(CompoundButton buttonView,
					boolean isChecked) {
				mIsRememberPassword = isChecked;
			}

		});
		mBtnLogin.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (mInputManager.isActive())
					mInputManager.hideSoftInputFromWindow(
							mBtnLogin.getWindowToken(), 0);
				if (validateInput()) {
					handleLogin();
					startActivity(new Intent(mContext, MainActivity.class));
				}
				//Update user's information by SharedPreferences
				if (mIsRememberPassword) {
					userInfo.edit()
							.putBoolean("isRemember", mIsRememberPassword)
							.commit();
					userInfo.edit()
							.putString("username",
									mEtUsername.getText().toString()).commit();
					userInfo.edit()
							.putString("password",
									mEtPassword.getText().toString()).commit();
				}

			}
		});
		mTvCreat.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(mContext, SignupActivity.class);
				startActivity(intent);

			}
		});
	}

	/**
	 * Handle the login request
	 */
	private void handleLogin() {
		AsyncTask<String, Integer, Boolean> loginTask = new AsyncTask<String, Integer, Boolean>() {

			private String message;

			@Override
			protected void onPreExecute() {
				if (mProgress == null) {
					mProgress = new ProgressDialog(LoginActivity.this);
				}
				mProgress.setTitle(R.string.processing);
				mProgress.setMessage(getString(R.string.process_login));
				mProgress.show();
				message = "";
			}

			@Override
			protected Boolean doInBackground(String... params) {
				// TODO using Resteasy framework instead
				/*
				 * String url =
				 * "http://vsf001.engagemobile.com/login?username=zxj&password=123"
				 * ; UserService_New service =
				 * ProxyFactory.create(UserService_New.class, url); Response
				 * response = service.userLogin("", "");
				 * 
				 * Log.d(TAG, response.getEntity().toString());
				 */
				UserService service = new UserService();
				String username = mEtUsername.getText().toString();
				String password = "";
				try {
					password = SHAUtil.getSHA(mEtPassword.getText().toString());
					User user = new User();
					user.setUsername(username);
					user.setPassword(password);
					Response response = service.login(user);
					if (response.getResponseResult().getSuccess()) {
						return true;
					} else {
						message = response.getResponseResult().getMessage();
						return false;
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
					// TODO things to do after login is success
					Toast.makeText(LoginActivity.this, "Login success!",
							Toast.LENGTH_SHORT).show();
					Map<String, String> params = new HashMap<String, String>();
					FlurryAgent.logEvent("Login Success");
				} else {
					showAlert(getString(R.string.login_failed), message);
				}
			}

		};
		loginTask.execute(new String[] {});
	}

	/**
	 * Check info user input whether missing or not.
	 * 
	 * @return true for whole user info, false for missing something
	 */
	private boolean validateInput() {
		if (mEtUsername.getText().toString().trim().equals("")) {
			Toast.makeText(LoginActivity.this,
					R.string.login_input_username_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtPassword.getText().toString().equals("")) {
			Toast.makeText(LoginActivity.this,
					R.string.login_input_password_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (mEtUsername.getText().toString().contains(" ")
				|| mEtUsername.getText().toString().contains("\t")) {
			Toast.makeText(LoginActivity.this, R.string.input_username_error,
					Toast.LENGTH_SHORT).show();
			return false;
		} else {
			return true;
		}

	}

	@Override
	protected void onStart() {
		super.onStart();
		FlurryAgent.onStartSession(this, "2JF57FZMZWGF34XR4238");
	}

	@Override
	protected void onStop() {
		super.onStop();
		FlurryAgent.onEndSession(this);
	}
}
