package com.engagemobile.vsfootball.fragment;

import android.app.FragmentTransaction;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.os.Handler;
import android.text.method.HideReturnsTransformationMethod;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.LoginActivity;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class PlayOutcomeFragment extends VsFootballFragment {
	private ImageView mIvDefensive;
	private ImageView mIvOffensive;
	private Button mBtnReplay;
	private Button mBtnSummary;
	private static PlayOutcomeFragment instance;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		instance = this;
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_play_outcome, null);
		mIvDefensive = (ImageView) rootView
				.findViewById(R.id.iv_outcome_defensive_play);
		mIvOffensive = (ImageView) rootView
				.findViewById(R.id.iv_outcome_offensive_play);
		mBtnReplay = (Button) rootView
				.findViewById(R.id.btn_outcome_instent_replay);
		mBtnSummary = (Button) rootView
				.findViewById(R.id.btn_outcome_game_summary);
		mIvDefensive.setBackgroundResource(R.drawable.defensive_play);
		mIvOffensive.setBackgroundResource(R.drawable.offensive_play);
		mBtnReplay.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				switchFragment(new PlayAnimationFragment(), false);
			}
		});
		mBtnSummary.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (GameSummaryFragment.getInstance() != null)
					switchFragment(
							GameSummaryFragment.getInstance(),
							false);
				else
					switchFragment(new GameSummaryFragment(),
							false);
			}
		});
		return rootView;
	}


	public static PlayOutcomeFragment getInstance() {
		return instance;
	}
}
