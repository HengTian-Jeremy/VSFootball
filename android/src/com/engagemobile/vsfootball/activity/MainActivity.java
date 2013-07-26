package com.engagemobile.vsfootball.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.FragmentManager;
import android.os.Bundle;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.view.ViewGroup.LayoutParams;
import android.widget.FrameLayout;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.fragment.MainFragment;
import com.engagemobile.vsfootball.view.adapter.PlayAdapter;

/**
 * This activity will show when you login succeed.
 * 
 * @author xiaoyuanhu
 */
public class MainActivity extends VsFootballActivity {
	private DrawerLayout mDrawerLayout;
	private ListView mPlaybookList;
	private PlayAdapter mPlayAdapter;
	private List<Play> mPlayList;
	private boolean isAdShowing;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		FragmentManager fragmentManager = getFragmentManager();
		fragmentManager.beginTransaction()
				.replace(R.id.content_frame, new MainFragment()).commit();
		mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
		mPlaybookList = (ListView) findViewById(R.id.left_playbook_list);
		mDrawerLayout.setDrawerShadow(R.drawable.drawer_shadow,
				GravityCompat.START);
		if (isAdShowing) {
			FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
					LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT);
			params.setMargins(0, 0, 0, 100);
			mDrawerLayout.setLayoutParams(params);
		}
		mockPlayList();
		mPlayAdapter = new PlayAdapter(this, mPlayList);
		mPlaybookList.setAdapter(mPlayAdapter);
	}

	/**
	 * Mock data of the plays which you can buy.
	 */
	private void mockPlayList() {
		mPlayList = new ArrayList<Play>();
		Play play1 = new Play(0, "Flea Flicker", null, null, 0);
		Play play2 = new Play(0, "Hail Mary", null, null, 0);
		Play play3 = new Play(0, "Wildcat 8-Pack", null, null, (float) 2.99);
		Play play4 = new Play(0, "Pistol 6-Pack", null, null, (float) 1.99);
		Play play5 = new Play(0, "Wishbone 4-Pack", null, null, (float) 0.99);
		Play play6 = new Play(0, "Tricks & Fakes", null, null, (float) 2.99);
		Play play7 = new Play(0, "46 Defense", null, null, (float) 2.99);
		Play play11 = new Play(0, "Flea Flicker", null, null, 0);
		Play play12 = new Play(0, "Hail Mary", null, null, 0);
		Play play13 = new Play(0, "Wildcat 8-Pack", null, null, (float) 2.99);
		Play play14 = new Play(0, "Pistol 6-Pack", null, null, (float) 1.99);
		Play play15 = new Play(0, "Wishbone 4-Pack", null, null, (float) 0.99);
		Play play16 = new Play(0, "Tricks & Fakes", null, null, (float) 2.99);
		Play play17 = new Play(0, "46 Defense", null, null, (float) 2.99);
		mPlayList.add(play1);
		mPlayList.add(play2);
		mPlayList.add(play3);
		mPlayList.add(play4);
		mPlayList.add(play5);
		mPlayList.add(play6);
		mPlayList.add(play7);
		mPlayList.add(play11);
		mPlayList.add(play12);
		mPlayList.add(play13);
		mPlayList.add(play14);
		mPlayList.add(play15);
		mPlayList.add(play16);
		mPlayList.add(play17);
	}
}