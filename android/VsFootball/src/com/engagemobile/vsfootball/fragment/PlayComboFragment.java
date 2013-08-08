package com.engagemobile.vsfootball.fragment;

import java.util.Timer;
import java.util.TimerTask;

import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.LoginActivity;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class PlayComboFragment extends VsFootballFragment {
	private ImageView mIvDefensive;
	private ImageView mIvOffensive;
	private TextView mTvDefensive;
	private TextView mTvOffensive;
	private TextView mTvTitle;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		mockData();
	}

	private void mockData() {
		// TODO Auto-generated method stub
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_play_combo, null);
		mIvDefensive = (ImageView) rootView
				.findViewById(R.id.iv_combo_defensive_play);
		mIvOffensive = (ImageView) rootView
				.findViewById(R.id.iv_combo_offensive_play);
		mTvDefensive = (TextView) rootView
				.findViewById(R.id.tv_combo_defensive_wait);
		mTvOffensive = (TextView) rootView
				.findViewById(R.id.tv_combo_offensive_wait);
		mTvTitle = (TextView) rootView
				.findViewById(R.id.tv_combo_title);
		mIvDefensive.setBackgroundResource(R.drawable.defensive_play);
		mIvOffensive.setBackgroundResource(R.drawable.offensive_play);
		if (activityParent.isOffensive) {
			mIvDefensive.setVisibility(View.INVISIBLE);
			mTvDefensive.setText(getResources().getString(
					R.string.combo_waiting, "Mike"));
		} else {
			mIvOffensive.setVisibility(View.INVISIBLE);
			mTvOffensive.setText(getResources().getString(
					R.string.combo_waiting, "Blue"));

		}
		new Handler().postDelayed(new Runnable() {
			public void run() {
				//execute the task    
				if (activityParent.isOffensive) {
					mIvDefensive.setVisibility(View.VISIBLE);
					mTvDefensive.setVisibility(View.INVISIBLE);

				} else {
					mIvOffensive.setVisibility(View.VISIBLE);
					mTvOffensive.setVisibility(View.INVISIBLE);

				}
				mTvTitle.setText("Mike 55...Blue 35...Hut-Hut...");
			}
		}, 3000);
		new Handler().postDelayed(new Runnable() {
			public void run() {
				//execute the task    
				activityParent.changeFragment(new PlayOutcomeFragment(), true);
			}
		}, 5000);
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.btnTitleBarAdd.setVisibility(View.GONE);
		activityParent.btnTitleBarList.setVisibility(View.GONE);
		activityParent.btnTitleBarBack.setVisibility(View.GONE);
		activityParent.btnTitleBarMsg.setVisibility(View.GONE);
		activityParent.tvTitleBarTitle.setText(getResources().getString(
				R.string.title));
		super.onResume();
	}
}
