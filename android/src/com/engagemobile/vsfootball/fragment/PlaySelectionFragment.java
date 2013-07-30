package com.engagemobile.vsfootball.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.view.adapter.ExpandablePlayAdapter;
import com.tjerkw.slideexpandable.library.ActionSlideExpandableListView;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class PlaySelectionFragment extends VsFootballFragment {
	private ActionSlideExpandableListView mLvChoosePlay;
	private ExpandablePlayAdapter mExpandablePlayAdapter;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		mExpandablePlayAdapter = new ExpandablePlayAdapter(mContext,
				MainActivity.mockPlayList());
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater
				.inflate(R.layout.fragment_play_selection, null);
		mLvChoosePlay = (ActionSlideExpandableListView) rootView
				.findViewById(R.id.lv_choose_play);
		mLvChoosePlay.setAdapter(mExpandablePlayAdapter);
		mLvChoosePlay.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
			}
		});
		return rootView;
	}
}
