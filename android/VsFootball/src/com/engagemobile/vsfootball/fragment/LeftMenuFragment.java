package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.LoginActivity;
import com.engagemobile.vsfootball.utils.ListViewUtil;
import com.engagemobile.vsfootball.view.adapter.MenuAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class LeftMenuFragment extends VsFootballFragment {
	private MenuAdapter mMenuAdapter;
	private ListView mMenuListView;

	@Override
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		mockData();
	}

	private void mockData() {
		// TODO Auto-generated method stub
		List<String> listMenuItem = new ArrayList<String>();
		listMenuItem.add("Game List");
		listMenuItem.add("Career Stats");
		listMenuItem.add("Vs.Sports Store");
		listMenuItem.add("FeedBack");
		listMenuItem.add("Help");
		listMenuItem.add("Sign out");
		mMenuAdapter = new MenuAdapter(mContext,
				listMenuItem);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_left_slid_menu, null);
		mMenuListView = (ListView) rootView.findViewById(R.id.lv_sliding_menu);
		mMenuListView.setAdapter(mMenuAdapter);
		ListViewUtil.setListViewHeightBasedOnChildren(mMenuListView);
		OnItemClickListener mOnItemClickListener = new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				if (position == 0) {
					if (GameListFragment.getInstance() == null)
						activityParent.changeFragment(new GameListFragment(),
								true);
					else if (activityParent.curFragment != GameListFragment
							.getInstance())
						activityParent.changeFragment(
								GameListFragment.getInstance(), true);
				}
				else if (position == 3) {
					activityParent.changeFragment(new FeedbackFragment(), true);
				} else if (position == 5) {
					startActivity(new Intent(mContext, LoginActivity.class));
				}
				activityParent.leftSlideMenu.toggle();
			}
		};
		mMenuListView.setOnItemClickListener(mOnItemClickListener);
		return rootView;
	}
}
