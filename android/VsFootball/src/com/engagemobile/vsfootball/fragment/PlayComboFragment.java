package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.view.adapter.StartNewGameAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class PlayComboFragment extends VsFootballFragment {
	private ListView mLvStartNewGame;
	private StartNewGameAdapter mAdapt;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		mockData();
	}

	private void mockData() {
		// TODO Auto-generated method stub
		List<String> listChoice = new ArrayList<String>();
		listChoice.add("Facebook Friends");
		listChoice.add("Contact List");
		listChoice.add("By Username/Email");
		listChoice.add("Random Opponent");
		mAdapt = new StartNewGameAdapter(mContext, listChoice);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_start_new_game, null);
		mLvStartNewGame = (ListView) rootView.findViewById(R.id.lv_start_new_game);
		mLvStartNewGame.setAdapter(mAdapt);
		return rootView;
	}
	@Override
	public void onResume() {
		activityParent.mBtnTitleBarAdd.setVisibility(View.GONE);
		activityParent.mBtnTitleBarList.setVisibility(View.GONE);
		activityParent.mBtnTitleBarBack.setVisibility(View.VISIBLE);
		activityParent.mTvTitleBarTitle.setText("Start a Game");
		super.onResume();
	}
}
