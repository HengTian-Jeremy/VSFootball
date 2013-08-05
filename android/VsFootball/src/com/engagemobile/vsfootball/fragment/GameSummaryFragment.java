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
	private static GameSummaryFragment instance;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		instance = this;
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
				activityParent.changeFragment(new PlaySelectionFragment(), true);
				activityParent.btnTitleBarMsg.setVisibility(View.GONE);
				if (activityParent.isOffensive)
					activityParent.tvTitleBarTitle.setText("Offensive");
				else
					activityParent.tvTitleBarTitle.setText("Defensive");
				activityParent.btnTitleBarList.setVisibility(View.GONE);
				activityParent.btnTitleBarBack.setVisibility(View.VISIBLE);
			}
		});
		mBtnReplay.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				FragmentTransaction mFragmentTransaction = activityParent
						.getFragmentManager()
						.beginTransaction();
				if (PlayAnimationFragment.getInstance() == null)
					mFragmentTransaction
							.replace(R.id.flyt_content,
									new PlayAnimationFragment());
				else
					mFragmentTransaction
							.replace(R.id.flyt_content,
									PlayAnimationFragment.getInstance());
				mFragmentTransaction.addToBackStack(null);
				mFragmentTransaction.commit();
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
		activityParent.btnTitleBarAdd.setVisibility(View.GONE);
		activityParent.tvTitleBarTitle.setText("Vs.FootBall");
		activityParent.btnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.btnTitleBarMsg.setVisibility(View.VISIBLE);
		activityParent.btnTitleBarBack.setVisibility(View.GONE);
		super.onResume();
	}

	public static GameSummaryFragment getInstance() {
		return instance;
	}

	public static void setInstance(GameSummaryFragment instance) {
		GameSummaryFragment.instance = instance;
	}

}
