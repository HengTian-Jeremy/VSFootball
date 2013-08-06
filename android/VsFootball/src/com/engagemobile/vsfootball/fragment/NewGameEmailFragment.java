package com.engagemobile.vsfootball.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import com.engagemobile.vsfootball.R;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class NewGameEmailFragment extends VsFootballFragment {
	private Button mBtnCancel;
	private Button mBtnSubmit;
	private EditText mEditText;
	private OnClickListener mOnClickListener;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		mOnClickListener = new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (v == mBtnCancel)
					activityParent.getFragmentManager().popBackStack();
				else if (v == mBtnSubmit)
					activityParent.getFragmentManager().popBackStack();
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
		mEditText = (EditText) rootView.findViewById(R.id.et_new_game_email);
		mBtnCancel.setOnClickListener(mOnClickListener);
		mBtnSubmit.setOnClickListener(mOnClickListener);
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.hideAd();
		activityParent.hideTitleBar();
		super.onResume();
	}

	@Override
	public void onPause() {
		activityParent.showAd();
		activityParent.showTitleBar();
		super.onPause();
	}
}
