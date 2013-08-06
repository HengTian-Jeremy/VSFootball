package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.utils.ListViewUtil;
import com.engagemobile.vsfootball.view.adapter.GameAdapter;
import com.engagemobile.vsfootball.view.adapter.NewOpponentsAdapter;
import com.engagemobile.vsfootball.view.adapter.PreOpponentsAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class StartNewGameFragment extends VsFootballFragment {
	private ListView mLvNewOpponents;
	private ListView mLvPreviousOpponents;
	private NewOpponentsAdapter mNewAdapt;
	private PreOpponentsAdapter mPreAdapt;

	@Override
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		// After super.onCreate(savedInstanceState) mContext will be assignment.
		mockData();
	}

	private void mockData() {
		List<String> listNewChoice = new ArrayList<String>();
		listNewChoice.add("Facebook Friends");
		listNewChoice.add("By Email");
		listNewChoice.add("Contact List");
		listNewChoice.add("Random Opponent");
		mNewAdapt = new NewOpponentsAdapter(mContext, listNewChoice);
		List<String> listPreChoice = new ArrayList<String>();
		listPreChoice.add("Billy Bob Bozos");
		mPreAdapt = new PreOpponentsAdapter(mContext, listPreChoice);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater
				.inflate(R.layout.fragment_start_new_game, null);
		mLvNewOpponents = (ListView) rootView
				.findViewById(R.id.lv_new_opponents);
		mLvPreviousOpponents = (ListView) rootView
				.findViewById(R.id.lv_previous_opponents);
		mLvNewOpponents.setAdapter(mNewAdapt);
		mLvPreviousOpponents.setAdapter(mPreAdapt);
		ListViewUtil.setListViewHeightBasedOnChildren(mLvNewOpponents);
		mLvNewOpponents.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				switch (position) {
				case 1:
					activityParent.changeFragment(new NewGameEmailFragment(),
							true);
					break;

				default:
					break;
				}
			}
		});
		ListViewUtil.setListViewHeightBasedOnChildren(mLvPreviousOpponents);
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.btnTitleBarAdd.setVisibility(View.GONE);
		activityParent.btnTitleBarList.setVisibility(View.GONE);
		activityParent.btnTitleBarBack.setVisibility(View.VISIBLE);
		activityParent.tvTitleBarTitle.setText("Start a Game");
		super.onResume();
	}
}
