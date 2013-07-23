package com.engagemobile.vsfootball.activity;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.engagemobile.vsfootball.R;

public class RegistActivity extends VsFootballActivity {
	private EditText etEmail;
	private EditText etPassword;
	private EditText etConfirm;
	private EditText etFirstname;
	private EditText etLastname;
	private Button btnJoin;
	private Context mContext;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_regist);
		mContext = this;
		initView();
	}

	private void initView() {
		// TODO Auto-generated method stub
		etEmail = (EditText) findViewById(R.id.et_email);
		etPassword = (EditText) findViewById(R.id.et_password);
		etConfirm = (EditText) findViewById(R.id.et_confirm);
		etFirstname = (EditText) findViewById(R.id.et_firstname);
		etLastname = (EditText) findViewById(R.id.et_lastname);
		btnJoin = (Button) findViewById(R.id.btn_join);
		btnJoin.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (checkInputInfo()) {
					Intent intent = new Intent(mContext, LoginActivity.class);
					startActivity(intent);
				}
			}
		});
	}

	/**
	 * @Description: Check info user input whether missing or not.
	 * @return true for whole user info, false for missing something
	 */
	private boolean checkInputInfo() {
		if (etFirstname.getText().toString().equals("")) {
			Toast.makeText(RegistActivity.this,
					R.string.register_input_firstname_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etLastname.getText().toString().equals("")) {
			Toast.makeText(RegistActivity.this,
					R.string.register_input_lastname_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etEmail.getText().toString().equals("")) {
			Toast.makeText(RegistActivity.this,
					R.string.register_input_email_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (checkEmail(etEmail.getText().toString())) {
			Toast.makeText(RegistActivity.this,
					R.string.register_input_email_error, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etPassword.getText().toString().trim().equals("")) {
			Toast.makeText(RegistActivity.this,
					R.string.register_input_password_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etConfirm.getText().toString().trim().equals("")) {
			Toast.makeText(RegistActivity.this, R.string.password_not_match,
					Toast.LENGTH_SHORT).show();
			return false;
		} else if (!etPassword.getText().toString()
				.equals(etConfirm.getText().toString())) {
			Toast.makeText(RegistActivity.this, R.string.password_not_match,
					Toast.LENGTH_SHORT).show();
			etPassword.setText("");
			etConfirm.setText("");
			etPassword.requestFocus();
			return false;
		} else {
			return true;
		}

	}

	public static boolean checkEmail(String email) {
		String str = "^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$";
		if (email == null)
			return false;
		Pattern regex = Pattern.compile(str);
		Matcher matcher = regex.matcher(email);
		boolean isMatched = matcher.matches();
		return isMatched;

	}
}
