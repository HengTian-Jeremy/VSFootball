package com.engagemobile.vsfootball.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;

import com.engagemobile.vsfootball.R;

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
					activityParent.changeFragment(
							PlayOutcomeFragment.getInstance(), true);
				else
					activityParent.changeFragment(new PlayOutcomeFragment(),
							true);
			}
		});
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.btnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.tvTitleBarTitle.setText(getResources().getString(
				R.string.title));
		super.onResume();
	}

	public static PlayAnimationFragment getInstance() {
		return instance;
	}

	public static void setInstance(PlayAnimationFragment instance) {
		PlayAnimationFragment.instance = instance;
	}
}
