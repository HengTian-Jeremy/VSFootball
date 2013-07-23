package com.engagemobile.vsfootball.activity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Paint;
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

public class LoginActivity extends VsFootballActivity {
	private TextView tvForgot;
	private boolean isRemember;
	private EditText etUsername;
	private EditText etPassword;
	private Button btnLogin;
	private Button btnFacebook;
	private CheckBox cbRemember;
	private InputMethodManager imm;
	private TextView tvCreat;
	private Context mContext;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_login);
		mContext = this;
		initView();
	}

	private void initView() {
		// TODO Auto-generated method stub
		imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
		etUsername = (EditText) findViewById(R.id.et_username);
		etPassword = (EditText) findViewById(R.id.et_password);
		btnLogin = (Button) findViewById(R.id.btn_login);
		btnFacebook = (Button) findViewById(R.id.btn_facebook);
		cbRemember = (CheckBox) findViewById(R.id.cb_remember);
		tvForgot = (TextView) this.findViewById(R.id.tv_forgot);
		tvCreat = (TextView) this.findViewById(R.id.tv_create);
		tvForgot.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG);
		tvCreat.getPaint().setFlags(Paint.UNDERLINE_TEXT_FLAG);
		final SharedPreferences userInfo = getSharedPreferences("user_info", 0);
		isRemember = userInfo.getBoolean("isRemember", true);
		String username = userInfo.getString("username", "");
		String password = userInfo.getString("password", "");
		etUsername.setText(username);
		etPassword.setText(password);
		cbRemember.setChecked(isRemember);
		cbRemember.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(CompoundButton buttonView,
					boolean isChecked) {
				// TODO Auto-generated method stub
				isRemember = isChecked;
			}
		});
		btnLogin.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (imm.isActive())
					imm.hideSoftInputFromWindow(btnLogin.getWindowToken(), 0);
				if (checkInputInfo()) {
					// post
				}
				if (isRemember) {
					userInfo.edit().putBoolean("isRemember", isRemember)
							.commit();
					userInfo.edit()
							.putString("username",
									etUsername.getText().toString()).commit();
					userInfo.edit()
							.putString("password",
									etPassword.getText().toString()).commit();
				}

			}
		});
		tvCreat.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(mContext, RegistActivity.class);
				startActivity(intent);

			}
		});
	}

	/**
	 * 
	 * @Description: Check info user input whether missing or not.
	 * 
	 * @return true for whole user info, false for missing something
	 */
	private boolean checkInputInfo() {
		if (etUsername.getText().toString().trim().equals("")) {
			Toast.makeText(LoginActivity.this,
					R.string.login_input_username_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etPassword.getText().toString().equals("")) {
			Toast.makeText(LoginActivity.this,
					R.string.login_input_password_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etUsername.getText().toString().contains(" ")
				|| etUsername.getText().toString().contains("\t")) {
			Toast.makeText(LoginActivity.this, R.string.input_username_error,
					Toast.LENGTH_SHORT).show();
			return false;
		} else {
			return true;
		}

	}

}
