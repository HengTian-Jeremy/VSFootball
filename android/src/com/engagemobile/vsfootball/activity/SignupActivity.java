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

public class SignupActivity extends VsFootballActivity {
	private EditText etEmail;
	private EditText etPassword;
	private EditText etConfirm;
	private EditText etFirstname;
	private EditText etLastname;
	private Button btnJoin;
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
					/*Intent intent = new Intent(mContext, LoginActivity.class);
					startActivity(intent);*/
					handleSignup();
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
			Toast.makeText(SignupActivity.this,
					R.string.register_input_firstname_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etLastname.getText().toString().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_lastname_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etEmail.getText().toString().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_email_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (!checkEmail(etEmail.getText().toString())) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_email_error, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etPassword.getText().toString().trim().equals("")) {
			Toast.makeText(SignupActivity.this,
					R.string.register_input_password_null, Toast.LENGTH_SHORT)
					.show();
			return false;
		} else if (etConfirm.getText().toString().trim().equals("")) {
			Toast.makeText(SignupActivity.this, R.string.password_not_match,
					Toast.LENGTH_SHORT).show();
			return false;
		} else if (!etPassword.getText().toString()
				.equals(etConfirm.getText().toString())) {
			Toast.makeText(SignupActivity.this, R.string.password_not_match,
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
				// TODO using Resteasy framework instead
				UserService service = new UserService();
				String email = etEmail.getText().toString();
				String password = "";
				try {
					password = SHAUtil.getSHA(etPassword.getText().toString());
				} catch (NoSuchAlgorithmException e) {
					return null;
				}
				String firstName = etFirstname.getText().toString();
				String lastName = etLastname.getText().toString();
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
