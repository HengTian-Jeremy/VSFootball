package com.engagemobile.vsfootball.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.fragment.GameListFragment;
import com.engagemobile.vsfootball.fragment.GameSummaryFragment;
import com.engagemobile.vsfootball.fragment.SlidingMenuFragment;
import com.engagemobile.vsfootball.fragment.StartNewGameFragment;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu.OnClosedListener;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu.OnOpenedListener;

/**
 * This activity will show when you login succeed.
 * 
 * @author xiaoyuanhu
 */
public class MainActivity extends VsFootballActivity {
	private boolean mIsAdShowing;
	private boolean mIsDrawerOpen;
	private FragmentManager mFragmentManager;
	public ImageButton btnTitleBarList;
	public ImageButton btnTitleBarAdd;
	public Button btnTitleBarBack;
	public ImageButton btnTitleBarMsg;
	public TextView tvTitleBarTitle;
	public boolean isOffensive;
	public SlidingMenu slideMenu;
	public Fragment curFragment;
	public RelativeLayout rlytTitleBar;
	public TextView tvAd;
	public String opponnentName;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		changeFragment(new GameListFragment(), false);
		btnTitleBarList = (ImageButton) findViewById(R.id.ibtn_titlebar_show_navi_list);
		btnTitleBarAdd = (ImageButton) findViewById(R.id.ibtn_titlebar_add);
		btnTitleBarBack = (Button) findViewById(R.id.btn_titlebar_back);
		tvTitleBarTitle = (TextView) findViewById(R.id.tv_titlebar_title);
		btnTitleBarMsg = (ImageButton) findViewById(R.id.ibtn_titlebar_msg);
		tvAd = (TextView) findViewById(R.id.tv_ad);
		rlytTitleBar = (RelativeLayout) findViewById(R.id.rlyt_title);
		addListener();
		initSlidingMenu();

	}

	private void initSlidingMenu() {
		// configure the SlidingMenu
		slideMenu = new SlidingMenu(this);
		slideMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		slideMenu.setShadowWidthRes(R.dimen.shadow_width);
		slideMenu.setShadowDrawable(R.drawable.slidemenu_shadow);
		slideMenu.setBehindOffsetRes(R.dimen.slidingmenu_offset);
		slideMenu.setFadeDegree(0.35f);
		slideMenu.attachToActivity(this, SlidingMenu.SLIDING_CONTENT);
		slideMenu.setMenu(R.layout.menu_frame);
		getFragmentManager().beginTransaction()
				.replace(R.id.menu_frame, new SlidingMenuFragment()).commit();
		slideMenu.setOnOpenedListener(new OnOpenedListener() {

			@Override
			public void onOpened() {
				// TODO Auto-generated method stub
				mIsDrawerOpen = true;
			}
		});
		slideMenu.setOnClosedListener(new OnClosedListener() {

			@Override
			public void onClosed() {
				// TODO Auto-generated method stub
				mIsDrawerOpen = false;
			}
		});
	}

	/**
	 * Mock data of the plays which you can buy.
	 */
	public static List<Play> mockPlayList() {
		List<Play> mListPlay = new ArrayList<Play>();
		Play play1 = new Play(0, "Flea Flicker", null, null, 0, 0);
		Play play2 = new Play(0, "Hail Mary", null, null, 0, 0);
		Play play3 = new Play(0, "Wildcat 8-Pack", null, null, (float) 2.99, 0);
		Play play4 = new Play(0, "Pistol 6-Pack", null, null, (float) 1.99, 0);
		Play play5 = new Play(0, "Wishbone 4-Pack", null, null, (float) 0.99, 0);
		Play play6 = new Play(0, "Tricks & Fakes", null, null, (float) 2.99, 0);
		Play play7 = new Play(0, "46 Defense", null, null, (float) 2.99, 0);
		Play play11 = new Play(0, "Flea Flicker", null, null, 0, 0);
		Play play12 = new Play(0, "Hail Mary", null, null, 0, 0);
		Play play13 = new Play(0, "Wildcat 8-Pack", null, null, (float) 2.99, 0);
		Play play14 = new Play(0, "Pistol 6-Pack", null, null, (float) 1.99, 0);
		Play play15 = new Play(0, "Wishbone 4-Pack", null, null, (float) 0.99,
				0);
		Play play16 = new Play(0, "Tricks & Fakes", null, null, (float) 2.99, 0);
		Play play17 = new Play(0, "46 Defense", null, null, (float) 2.99, 0);
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
		return mListPlay;
	}

	private void addListener() {
		OnClickListener mOnClickListener = new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (v == btnTitleBarList)
					slideMenu.toggle();
				else if (v == btnTitleBarBack)
					getFragmentManager()
							.popBackStack();
				else if (v == btnTitleBarAdd) {
					changeFragment(new StartNewGameFragment(), true);
				}
			}
		};
		btnTitleBarList.setOnClickListener(mOnClickListener);
		btnTitleBarBack.setOnClickListener(mOnClickListener);
		btnTitleBarAdd.setOnClickListener(mOnClickListener);
	}

	@Override
	public void onBackPressed() {
		// TODO Auto-generated method stub
		if (mIsDrawerOpen)
			slideMenu.toggle();
		else
			super.onBackPressed();
	}

	public void showAd() {
		tvAd.setVisibility(View.VISIBLE);
	}

	public void hideAd() {
		tvAd.setVisibility(View.GONE);
	}

	public void showTitleBar() {
		rlytTitleBar.setVisibility(View.VISIBLE);
	}

	public void hideTitleBar() {
		rlytTitleBar.setVisibility(View.GONE);
	}

	public void changeFragment(Fragment fragment, boolean isAddToBackStack) {
		curFragment = fragment;
		FragmentTransaction mFragmentTransaction = getFragmentManager()
				.beginTransaction();
		mFragmentTransaction
				.replace(R.id.flyt_content, fragment);
		if (isAddToBackStack)
			mFragmentTransaction.addToBackStack(null);
		mFragmentTransaction.commit();
	}
}