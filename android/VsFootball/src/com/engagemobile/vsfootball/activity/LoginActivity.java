package com.engagemobile.vsfootball.activity;

import java.security.NoSuchAlgorithmException;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
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
import com.engagemobile.vsfootball.bean.ModelContext;
import com.engagemobile.vsfootball.bean.User;
import com.engagemobile.vsfootball.integration.FlurryEventId;
import com.engagemobile.vsfootball.integration.FlurryLogEvent;
import com.engagemobile.vsfootball.integration.FlurryParam;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.UserService;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.net.bean.UserResult;
import com.engagemobile.vsfootball.utils.SHAUtil;
import com.facebook.Session;
import com.facebook.SessionState;
import com.facebook.UiLifecycleHelper;
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
	private Button mBtnFacebookLogin;
	private CheckBox mChkRemember;
	private TextView mTvCreat;
	private Context mContext;
	private InputMethodManager mInputManager;
	private TextView mTvTitle;
	private boolean mIsRememberPassword;
	private OnClickListener mOnClickListener;
	private UiLifecycleHelper uiHelper;
	private SharedPreferences userInfo;
	private Session.StatusCallback mCallback =
			new Session.StatusCallback() {

				@Override
				public void call(Session session, SessionState state,
						Exception exception) {
					if (state.isOpened()) {
						Toast.makeText(LoginActivity.this, "session is open",
								Toast.LENGTH_LONG).show();
					} else if (state.isClosed()) {
						Toast.makeText(LoginActivity.this, "session is close",
								Toast.LENGTH_LONG).show();
					}

				}
			};

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_login);
		mContext = this;
		uiHelper = new UiLifecycleHelper(this, mCallback);
		uiHelper.onCreate(savedInstanceState);
		initView();
		/*
		PackageInfo info;

		
		// get the HASH KEY
		try {
			info = getPackageManager().getPackageInfo(
					"com.engagemobile.vsfootball",
					PackageManager.GET_SIGNATURES);
			for (Signature signature : info.signatures)
			{
				MessageDigest md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				Log.d("KeyHash:",
						Base64.encodeToString(md.digest(), Base64.DEFAULT));
			}
		} catch (NameNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
	}

	/**
	 * This method is used to initialize all controls in this activity
	 */
	private void initView() {
		mInputManager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
		mEtUsername = (EditText) findViewById(R.id.et_username);
		mEtPassword = (EditText) findViewById(R.id.et_password);
		mBtnLogin = (Button) findViewById(R.id.btn_login);
		mBtnFacebookLogin = (Button) findViewById(R.id.btn_facebook_login);
		mChkRemember = (CheckBox) findViewById(R.id.cb_remember);
		mTvForgetPassword = (TextView) this.findViewById(R.id.tv_forgot);
		mTvCreat = (TextView) this.findViewById(R.id.tv_create);
		mTvTitle = (TextView) findViewById(R.id.tv_title);
		Typeface font = Typeface.createFromAsset(getAssets(),
				"fonts/SketchRockwell.ttf");
		mTvTitle.setTypeface(font);
		mTvForgetPassword.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG);
		mTvCreat.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG);
		userInfo = getSharedPreferences("user_info", 0);
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
				}
				// Update user's information by SharedPreferences
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
				Intent intent = new Intent(mContext, SignUpActivity.class);
				startActivity(intent);

			}
		});
		mTvForgetPassword.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(mContext,
						PasswordRecoveryActivity.class);
				startActivity(intent);
			}
		});
	}

	/**
	 * Handle the login request
	 */
	private void handleLogin() {
		AsyncTask<String, Integer, Response> loginTask = new AsyncTask<String, Integer, Response>() {

			@Override
			protected void onPreExecute() {
				showProgress(R.string.processing, R.string.process_login);
			}

			@Override
			protected Response doInBackground(String... params) {
				UserService service = new UserService();
				String username = mEtUsername.getText().toString();
				String password = "";
				try {
					password = SHAUtil.getSHA(mEtPassword.getText().toString());
				} catch (NoSuchAlgorithmException e) {
					Log.e(TAG, "Error on convert password to SHA-1", e);
				}
				User user = new User();
				user.setUsername(username);
				user.setPassword(password);
				try {
					return service.login(user);
				} catch (NetException e) {
					return null;
				}

			}

			@Override
			protected void onPostExecute(Response response) {
				dismissProgress();
				if (response != null && response.getResponseResult() != null) {
					if (response.getResponseResult().getSuccess()) {
						User user = new User();
						UserResult result = (UserResult) (response
								.getResponseResult());
						user.setGuid(result.getGuid());
						ModelContext.getInstance().setCurrentUser(user);
						ModelContext.getInstance().setGuid(result.getGuid());
						startActivity(new Intent(mContext, MainActivity.class));
					} else {
						showAlert(getString(R.string.login_failed), response
								.getResponseResult().getMessage());
						FlurryLogEvent logEvent = new FlurryLogEvent(
								FlurryEventId.LOGIN_FAILED);
						logEvent.addParam(FlurryParam.MESSAGE, response
								.getResponseResult().getMessage());
						logEvent.send();
					}
				} else {
					showAlert(
							getString(R.string.login_failed),
							getString(R.string.login_failed_please_check_network));
					FlurryLogEvent logEvent = new FlurryLogEvent(
							FlurryEventId.LOGIN_FAILED);
					logEvent.addParam(FlurryParam.MESSAGE,
							"Network connection problem");
					logEvent.send();
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

	@Override
	public void onBackPressed() {
		SplashActivity.getInstance().finish();
		super.onBackPressed();
	}

	@Override
	protected void onResume() {
		super.onResume();
		uiHelper.onResume();
	}

	@Override
	protected void onPause() {
		super.onPause();
		uiHelper.onPause();
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		uiHelper.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		uiHelper.onDestroy();
	}

	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		uiHelper.onSaveInstanceState(outState);
	}

}
