package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.library.ActionSlideExpandableListView;
import com.engagemobile.vsfootball.view.adapter.ExpandablePlayAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class PlaySelectionFragment extends VsFootballFragment {
	private ActionSlideExpandableListView mLvChoosePlay;
	private ExpandablePlayAdapter mExPlayAdapter;
	private RadioGroup mRgPlayType;
	private List<Play> mListRunPlay;
	private List<Play> mListPassPlay;
	private List<Play> mListSpecialPlay;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		mockPlayList();
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater
				.inflate(R.layout.fragment_play_selection, null);
		mLvChoosePlay = (ActionSlideExpandableListView) rootView
				.findViewById(R.id.lv_choose_play);
		mRgPlayType = (RadioGroup) rootView.findViewById(R.id.rg_play_type);
		mLvChoosePlay.setAdapter(mExPlayAdapter);
		mRgPlayType.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				// TODO Auto-generated method stub
				if (checkedId == mRgPlayType.getChildAt(0).getId()) {
					mExPlayAdapter.setmPlayList(mListRunPlay);
				}
				else if (checkedId == mRgPlayType.getChildAt(1).getId()) {
					mExPlayAdapter.setmPlayList(mListPassPlay);
				}
				else if (checkedId == mRgPlayType.getChildAt(2).getId()) {
					mExPlayAdapter.setmPlayList(mListSpecialPlay);
				}
				mExPlayAdapter.notifyDataSetChanged();
			}
		});
		mLvChoosePlay.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
			}
		});
		return rootView;
	}

	/**
	 * Mock data of the plays which you can choose.
	 */
	private void mockPlayList() {
		mListRunPlay = new ArrayList<Play>();
		Play play1 = new Play(0, "Run Flea Flicker", null, null, 0,
				R.drawable.play);
		Play play2 = new Play(0, "Run Hail Mary", null, null, 0,
				R.drawable.play);
		Play play3 = new Play(0, "Run Wildcat 8-Pack", null, null,
				(float) 2.99, R.drawable.play);
		Play play4 = new Play(0, "Run Pistol 6-Pack", null, null, (float) 1.99,
				R.drawable.play);
		Play play5 = new Play(0, "Run Wishbone 4-Pack", null, null,
				(float) 0.99, R.drawable.play);
		Play play6 = new Play(0, "Run Tricks & Fakes", null, null,
				(float) 2.99, R.drawable.play);
		Play play7 = new Play(0, "Run 46 Defense", null, null, (float) 2.99,
				R.drawable.play);
		mListRunPlay.add(play1);
		mListRunPlay.add(play2);
		mListRunPlay.add(play3);
		mListRunPlay.add(play4);
		mListRunPlay.add(play5);
		mListRunPlay.add(play6);
		mListRunPlay.add(play7);
		mListPassPlay = new ArrayList<Play>();
		Play play11 = new Play(0, "Pass Flea Flicker", null, null, 0,
				R.drawable.play);
		Play play12 = new Play(0, "Pass Hail Mary", null, null, 0,
				R.drawable.play);
		Play play13 = new Play(0, "Pass Wildcat 8-Pack", null, null,
				(float) 2.99, R.drawable.play);
		Play play14 = new Play(0, "Pass Pistol 6-Pack", null, null,
				(float) 1.99, R.drawable.play);
		Play play15 = new Play(0, "Pass Wishbone 4-Pack", null, null,
				(float) 0.99, R.drawable.play);
		Play play16 = new Play(0, "Pass Tricks & Fakes", null, null,
				(float) 2.99, R.drawable.play);
		Play play17 = new Play(0, "Pass 46 Defense", null, null, (float) 2.99,
				R.drawable.play);
		mListPassPlay.add(play11);
		mListPassPlay.add(play12);
		mListPassPlay.add(play13);
		mListPassPlay.add(play14);
		mListPassPlay.add(play15);
		mListPassPlay.add(play16);
		mListPassPlay.add(play17);
		mListSpecialPlay = new ArrayList<Play>();
		Play play21 = new Play(0, "Special Flea Flicker", null, null, 0,
				R.drawable.play);
		Play play22 = new Play(0, "Special Hail Mary", null, null, 0,
				R.drawable.play);
		Play play23 = new Play(0, "Special Wildcat 8-Pack", null, null,
				(float) 2.99, R.drawable.play);
		Play play24 = new Play(0, "Special Pistol 6-Pack", null, null,
				(float) 1.99, R.drawable.play);
		Play play25 = new Play(0, "Special Wishbone 4-Pack", null, null,
				(float) 0.99, R.drawable.play);
		Play play26 = new Play(0, "Special Tricks & Fakes", null, null,
				(float) 2.99, R.drawable.play);
		Play play27 = new Play(0, "Special 46 Defense", null, null,
				(float) 2.99, R.drawable.play);
		mListSpecialPlay.add(play21);
		mListSpecialPlay.add(play22);
		mListSpecialPlay.add(play23);
		mListSpecialPlay.add(play24);
		mListSpecialPlay.add(play25);
		mListSpecialPlay.add(play26);
		mListSpecialPlay.add(play27);
		mExPlayAdapter = new ExpandablePlayAdapter(mContext, mListRunPlay);
	}

	/**
	 * Builds dummy data for the test. In a real app this would be an adapter
	 * for your data. For example a CursorAdapter
	 */
	public ListAdapter buildDummyData() {
		final int SIZE = 10;
		String[] values = new String[SIZE];
		for (int i = 0; i < SIZE; i++) {
			values[i] = "Item " + i;
		}
		return new ArrayAdapter<String>(
				mContext,
				R.layout.list_item_expandable_play,
				R.id.tv_play_name,
				values);
	}
}
