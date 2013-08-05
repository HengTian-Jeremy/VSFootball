package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.view.adapter.GameAdapter;
import com.engagemobile.vsfootball.view.adapter.StartNewGameAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class FeedbackFragment extends VsFootballFragment {
	private Button mBtnCancel;
	private Button mBtnSubmit;
	private OnClickListener mOnClickListener;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		mOnClickListener = new OnClickListener() {
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_feedback, null);
		mBtnCancel = (Button) rootView.findViewById(R.id.btn_feedback_cancel);
		mBtnSubmit = (Button) rootView.findViewById(R.id.btn_feedback_submit);
		mBtnCancel.setOnClickListener(mOnClickListener);
		mBtnSubmit.setOnClickListener(mOnClickListener);
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.btnTitleBarAdd.setVisibility(View.GONE);
		activityParent.btnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.btnTitleBarBack.setVisibility(View.GONE);
		activityParent.tvTitleBarTitle.setText(getString(R.string.login_title));
		super.onResume();
	}
}
