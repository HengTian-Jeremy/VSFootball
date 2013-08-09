package com.engagemobile.vsfootball.fragment;

import android.os.Bundle;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.SlidingDrawer;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Game;
import com.engagemobile.vsfootball.bean.ModelContext;
import com.engagemobile.vsfootball.bean.Scoreboard;
import com.engagemobile.vsfootball.view.DotMatrixDigitView;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;

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
	private DotMatrixDigitView mDmdvAwayScore;
	private DotMatrixDigitView mDmdvTimeHour;
	private DotMatrixDigitView mDmdvTimeMin;
	private DotMatrixDigitView mDmdvDown;
	private DotMatrixDigitView mDmdvToDo;
	private DotMatrixDigitView mDmdvBO;
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
		mDmdvHomeScore = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_home);
		mDmdvAwayScore = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_away);
		mDmdvTimeHour = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_time_hour);
		mDmdvTimeMin = (DotMatrixDigitView) rootView
				.findViewById(R.id.dmgv_time_min);
		mDmdvDown = (DotMatrixDigitView) rootView.findViewById(R.id.dmgv_down);
		mDmdvToDo = (DotMatrixDigitView) rootView.findViewById(R.id.dmgv_to_go);
		mDmdvBO = (DotMatrixDigitView) rootView.findViewById(R.id.dmgv_b_o);
		// mTouchImage = (ImageView) rootView.findViewById(R.id.touch_image);
		mBtnReplay = (Button) rootView.findViewById(R.id.btn_instant_replay);
		mBtnNextPlay = (Button) rootView
				.findViewById(R.id.btn_choose_next_play);
		// mockScoreBoard(rootView);
		// display the scoreboard and hide the handle
		mDrawerScoreboard.open();
		mLytScoreboardHandle = (View) mDrawerScoreboard
				.findViewById(R.id.rlyt_scoreboard_handle);
		mLytScoreboardHandle.setVisibility(View.INVISIBLE);

		Game game = ModelContext.getInstance().getCurrentSelectedGame();
		Scoreboard score = new Scoreboard();
		updateScoreboard(score);

		mBtnNextPlay.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				switchFragment(new PlaySelectionFragment(), true);
			}
		});
		mBtnReplay.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (PlayAnimationFragment.getInstance() == null)
					switchFragment(new PlayAnimationFragment(), false);
				else
					switchFragment(PlayAnimationFragment.getInstance(), false);
			}
		});
		return rootView;
	}

	/*private void mockScoreBoard(View rootView) {
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
	}*/

	private void updateScoreboard(Scoreboard score) {

	}

	public static GameSummaryFragment getInstance() {
		return instance;
	}

	public static void setInstance(GameSummaryFragment instance) {
		GameSummaryFragment.instance = instance;
	}

}
