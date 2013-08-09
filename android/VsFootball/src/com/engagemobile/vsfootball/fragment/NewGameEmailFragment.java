package com.engagemobile.vsfootball.fragment;

import java.security.NoSuchAlgorithmException;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.LoginActivity;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.bean.ModelContext;
import com.engagemobile.vsfootball.bean.User;
import com.engagemobile.vsfootball.integration.FlurryEventId;
import com.engagemobile.vsfootball.integration.FlurryLogEvent;
import com.engagemobile.vsfootball.integration.FlurryParam;
import com.engagemobile.vsfootball.net.GameService;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.UserService;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.net.bean.UserResult;
import com.engagemobile.vsfootball.utils.SHAUtil;
import com.engagemobile.vsfootball.utils.ValidateUtil;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class NewGameEmailFragment extends VsFootballFragment {
	private Button mBtnCancel;
	private Button mBtnSubmit;
	private EditText mEtEmail;
	private ProgressDialog mProgress;
	private OnClickListener mOnClickListener;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		mOnClickListener = new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (v == mBtnCancel)
					activityParent.getSupportFragmentManager().popBackStack();
				else if (v == mBtnSubmit) {
					String email = mEtEmail.getText().toString();
					if (ValidateUtil.validateEmail(email)) {
						inviteByEmail(email);
					}
					switchFragment(new NewGameOptionsFragment(), true);
				}

			}
		};
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater
				.inflate(R.layout.fragment_new_game_email, null);
		mBtnCancel = (Button) rootView
				.findViewById(R.id.btn_new_game_email_cancel);
		mBtnSubmit = (Button) rootView
				.findViewById(R.id.btn_new_game_email_submit);
		mEtEmail = (EditText) rootView.findViewById(R.id.et_new_game_email);
		mBtnCancel.setOnClickListener(mOnClickListener);
		mBtnSubmit.setOnClickListener(mOnClickListener);
		return rootView;
	}

	private void inviteByEmail(String email) {
		AsyncTask<String, Integer, Response> inviteByEmailTask = new AsyncTask<String, Integer, Response>() {

			@Override
			protected void onPreExecute() {
				if (mProgress == null) {
					mProgress = new ProgressDialog(getActivity());
				}
				mProgress.setTitle(R.string.processing);
				mProgress.setMessage(getString(R.string.process_login));
				mProgress.show();
			}

			@Override
			protected Response doInBackground(String... params) {
				GameService service = new GameService();
				try {
					return service.inviteToJoinByEmail(params[0]);
				} catch (NetException e) {
					return null;
				}

			}

			@Override
			protected void onPostExecute(Response response) {
				mProgress.dismiss();
			}

		};
		inviteByEmailTask.execute(new String[] { email });
	}
}
