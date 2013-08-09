package com.engagemobile.vsfootball.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;

import com.engagemobile.vsfootball.R;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class PlayAnimationFragment extends VsFootballFragment {
	private ImageView mIvanimation;
	private Button mBtnReplay;
	private Button mBtnSkip;
	private static PlayAnimationFragment instance;

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
		View rootView = inflater
				.inflate(R.layout.fragment_play_animation, null);
		mIvanimation = (ImageView) rootView
				.findViewById(R.id.iv_animation_screen);
		mBtnReplay = (Button) rootView
				.findViewById(R.id.btn_animation_replay);
		mBtnSkip = (Button) rootView
				.findViewById(R.id.btn_animation_skip);
		mBtnReplay.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

			}
		});
		mBtnSkip.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (PlayOutcomeFragment.getInstance() != null)
				switchFragment(PlayOutcomeFragment.getInstance(), false);
				else
					switchFragment(new PlayOutcomeFragment(), false);
			}
		});
		return rootView;
	}

	public static PlayAnimationFragment getInstance() {
		return instance;
	}

	public static void setInstance(PlayAnimationFragment instance) {
		PlayAnimationFragment.instance = instance;
	}
}
