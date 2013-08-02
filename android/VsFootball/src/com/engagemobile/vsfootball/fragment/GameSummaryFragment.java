package com.engagemobile.vsfootball.fragment;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.text.Layout;
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
public class GameSummaryFragment extends VsFootballFragment {
	private SlidingDrawer mDrawerScoreboard;
	private ImageView mTouchImage;
	private Button mBtnReplay;
	private Button mBtnNextPlay;
	private DotMatrixDigitView mDmdvHomeScore;
	private View mLytScoreboardHandle;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_game_summary, null);
		mDrawerScoreboard = (SlidingDrawer) rootView
				.findViewById(R.id.scoreboard_drawer);
		//		mTouchImage = (ImageView) rootView.findViewById(R.id.touch_image);
		mBtnReplay = (Button) rootView.findViewById(R.id.btn_instant_replay);
		mBtnNextPlay = (Button) rootView
				.findViewById(R.id.btn_choose_next_play);
		mockScoreBoard(rootView);
		// display the scoreboard and hide the handle
		mDrawerScoreboard.open();
		mLytScoreboardHandle = (View) mDrawerScoreboard
				.findViewById(R.id.rlyt_scoreboard_handle);
		mLytScoreboardHandle.setVisibility(View.INVISIBLE);
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
				activityParent.mBtnTitleBarMsg.setVisibility(View.GONE);
				if (activityParent.isOffensive)
					activityParent.mTvTitleBarTitle.setText("Offensive");
				else
					activityParent.mTvTitleBarTitle.setText("Defensive");
				activityParent.mBtnTitleBarList.setVisibility(View.GONE);
				activityParent.mBtnTitleBarBack.setVisibility(View.VISIBLE);
			}
		});
		return rootView;
	}

	private void mockScoreBoard(View rootView) {
		// TODO Auto-generated method stub
		mDmdvHomeScore = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_home);
		mDmdvHomeScore.setDigit(11);
		DotMatrixDigitView mDmdvAwayScore = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_away);
		mDmdvAwayScore.setDigit(13);
		DotMatrixDigitView mDmdvTimeHour = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_time_hour);
		mDmdvTimeHour.setDigit(12);
		DotMatrixDigitView mDmdvTimeMin = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_time_min);
		mDmdvTimeMin.setDigit(28);
		DotMatrixDigitView mDmdvDown = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_down);
		mDmdvDown.setDigit(2);
		DotMatrixDigitView mDmdvToDo = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_to_go);
		mDmdvToDo.setDigit(10);
		DotMatrixDigitView mDmdvBO = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_b_o);
		mDmdvBO.setDigit(38);
	}

	@Override
	public void onResume() {
		activityParent.mBtnTitleBarAdd.setVisibility(View.GONE);
		activityParent.mTvTitleBarTitle.setText("Vs.FootBall");
		activityParent.mBtnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.mBtnTitleBarMsg.setVisibility(View.VISIBLE);
		activityParent.mBtnTitleBarBack.setVisibility(View.GONE);
		super.onResume();
	}

}
