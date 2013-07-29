package com.engagemobile.vsfootball.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.FragmentManager;
import android.os.Bundle;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v4.widget.DrawerLayout.DrawerListener;
import android.view.Gravity;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.fragment.GameListFragment;
import com.engagemobile.vsfootball.fragment.MainFragment;
import com.engagemobile.vsfootball.view.adapter.PlayAdapter;

/**
 * This activity will show when you login succeed.
 * 
 * @author xiaoyuanhu
 */
public class MainActivity extends VsFootballActivity {
	private DrawerLayout mDrawerLayout;
	private ListView mLvPlaybook;
	private PlayAdapter mPlayAdapter;
	private List<Play> mListPlay;
	private boolean mIsAdShowing;
	private Button mBtnLeftDrawer;
	private boolean mIsDrawerOpen;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_main);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,
				R.layout.custom_titlebar);
		FragmentManager fragmentManager = getFragmentManager();
		fragmentManager.beginTransaction()
				.replace(R.id.flyt_content, new GameListFragment()).commit();
		mDrawerLayout = (DrawerLayout) findViewById(R.id.dlyt_my);
		mLvPlaybook = (ListView) findViewById(R.id.lv_playbook);
		mBtnLeftDrawer = (Button) findViewById(R.id.btn_titlebar_left_drawer);
		mDrawerLayout.setDrawerShadow(R.drawable.drawer_shadow,
				GravityCompat.START);
		if (mIsAdShowing) {
			FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
					LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT);
			params.setMargins(0, 0, 0, 100);
			mDrawerLayout.setLayoutParams(params);
		}
		mockPlayList();
		mPlayAdapter = new PlayAdapter(this, mListPlay);
		mLvPlaybook.setAdapter(mPlayAdapter);
		mBtnLeftDrawer.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (mIsDrawerOpen)
					mDrawerLayout.closeDrawers();
				else
					mDrawerLayout.openDrawer(GravityCompat.START);
			}
		});
		mDrawerLayout.setDrawerListener(new DrawerListener() {

			@Override
			public void onDrawerStateChanged(int arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public void onDrawerSlide(View arg0, float arg1) {
				// TODO Auto-generated method stub

			}

			@Override
			public void onDrawerOpened(View arg0) {
				// TODO Auto-generated method stub
				mIsDrawerOpen = true;
			}

			@Override
			public void onDrawerClosed(View arg0) {
				// TODO Auto-generated method stub
				mIsDrawerOpen = false;
			}
		});
	}

	/**
	 * Mock data of the plays which you can buy.
	 */
	private void mockPlayList() {
		mListPlay = new ArrayList<Play>();
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
		mListPlay.add(play1);
		mListPlay.add(play2);
		mListPlay.add(play3);
		mListPlay.add(play4);
		mListPlay.add(play5);
		mListPlay.add(play6);
		mListPlay.add(play7);
		mListPlay.add(play11);
		mListPlay.add(play12);
		mListPlay.add(play13);
		mListPlay.add(play14);
		mListPlay.add(play15);
		mListPlay.add(play16);
		mListPlay.add(play17);
	}

}