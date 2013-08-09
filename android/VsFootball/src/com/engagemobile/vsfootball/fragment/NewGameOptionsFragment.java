package com.engagemobile.vsfootball.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class NewGameOptionsFragment extends VsFootballFragment {
	private RadioGroup mRgPossession;
	private TextView mTvVs;
	private Button mBtnCall;
	private EditText mEtTeamName;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater
				.inflate(R.layout.fragment_new_game_options, null);
		mRgPossession = (RadioGroup) rootView.findViewById(R.id.rg_possession);
		mTvVs = (TextView) rootView.findViewById(R.id.tv_new_game_vs);
		mBtnCall = (Button) rootView
				.findViewById(R.id.btn_new_game_options_call);
		mEtTeamName = (EditText) rootView
				.findViewById(R.id.et_new_game_options_team_name);
		mTvVs.setText("New Game Vs " + activityParent.opponnentName);
		mRgPossession.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				// TODO Auto-generated method stub
				if (checkedId == mRgPossession.getChildAt(0).getId()) {
				}
				else if (checkedId == mRgPossession.getChildAt(1).getId()) {
				}
			}
		});
		mBtnCall.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				activityParent.changeFragment(new PlaySelectionFragment(),
						false);
			}
		});
		return rootView;
	}

	@Override
	public void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
	}

}
