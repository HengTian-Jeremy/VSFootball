package com.engagemobile.vsfootball.fragment;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.webkit.WebView.FindListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.SlidingDrawer;
import android.widget.SlidingDrawer.OnDrawerCloseListener;
import android.widget.SlidingDrawer.OnDrawerOpenListener;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.view.DotMatrixDigitView;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class GameFragment extends VsFootballFragment {
	private SlidingDrawer mDrawerScoreboard;
	private ImageView mTouchImage;
	private Button mBtnReplay;
	private Button mBtnNextPlay;
	private DotMatrixDigitView mDmdvHomeScore;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_home, null);
		mDrawerScoreboard = (SlidingDrawer) rootView
				.findViewById(R.id.scoreboard_drawer);
		mTouchImage = (ImageView) rootView.findViewById(R.id.touch_image);
		mBtnReplay = (Button) rootView.findViewById(R.id.btn_instant_replay);
		mBtnNextPlay = (Button) rootView
				.findViewById(R.id.btn_choose_next_play);
		mDmdvHomeScore = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_home);
		mDmdvHomeScore.setDigit(11);
		mDrawerScoreboard.setOnDrawerOpenListener(new OnDrawerOpenListener() {
			public void onDrawerOpened() {
				//TODO Auto-generated method stub

			}
		});
		mDrawerScoreboard.setOnDrawerCloseListener(new OnDrawerCloseListener() {

			public void onDrawerClosed() {
				//TODO Auto-generated method stub
			}
		});
		mBtnNextPlay.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				FragmentTransaction mFragmentTransaction = activityParent
						.getFragmentManager()
						.beginTransaction();
				mFragmentTransaction
						.replace(R.id.flyt_content, new PlaySelectionFragment());
				mFragmentTransaction.addToBackStack(null);
				mFragmentTransaction.commit();
				MainActivity mainActivy = (MainActivity) activityParent;
				mainActivy.mBtnTitleBarAdd.setVisibility(View.GONE);
				mainActivy.mTvTitleBarTitle.setText("Defensive");
				mainActivy.mBtnTitleBarLeftDrawer.setVisibility(View.GONE);
				mainActivy.mBtnTitleBarBack.setVisibility(View.VISIBLE);
				mainActivy.mBtnTitleBarBack
						.setOnClickListener(new OnClickListener() {

							@Override
							public void onClick(View v) {
								activityParent.getFragmentManager()
										.popBackStack();
							}
						});
			}
		});
		return rootView;
	}

	@Override
	public void onResume() {
		MainActivity mainActivy = (MainActivity) activityParent;
		mainActivy.mBtnTitleBarAdd.setVisibility(View.VISIBLE);
		mainActivy.mTvTitleBarTitle.setText("Vs.FootBall");
		mainActivy.mBtnTitleBarLeftDrawer.setVisibility(View.VISIBLE);
		mainActivy.mBtnTitleBarBack.setVisibility(View.GONE);
		super.onResume();
	}

}
