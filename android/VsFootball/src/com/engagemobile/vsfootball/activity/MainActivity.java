package com.engagemobile.vsfootball.activity;

import java.util.ArrayList;
import java.util.List;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.fragment.GameListFragment;
import com.engagemobile.vsfootball.fragment.LeftMenuFragment;
import com.engagemobile.vsfootball.fragment.RightMenuFragment;
import com.engagemobile.vsfootball.fragment.StartNewGameFragment;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;
import com.jeremyfeinstein.slidingmenu.lib.app.SlidingFragmentActivity;

/**
 * This activity will show when you login succeed.
 * 
 * @author xiaoyuanhu
 */
public class MainActivity extends SlidingFragmentActivity {
	private boolean mIsAdShowing;
	private FragmentManager mFragmentManager;
	public ImageButton btnTitleBarList;
	public ImageButton btnTitleBarAdd;
	public Button btnTitleBarBack;
	public ImageButton btnTitleBarMsg;
	public TextView tvTitleBarTitle;
	public boolean isOffensive;
	public Fragment curFragment;
	public RelativeLayout rlytTitleBar;
	public TextView tvAd;
	public String opponnentName;

	private int mTitleRes;
	public LeftMenuFragment leftMenuFragment;
	public SlidingMenu leftSlideMenu;
	public SlidingMenu rightSlideMenu;

	@Override
	public void onCreate(Bundle savedInstanceState) {
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
		initSlidingMenu(savedInstanceState);
		addListener();

	}

	private void initSlidingMenu(Bundle savedInstanceState) {
		// set the Behind View
		setBehindContentView(R.layout.menu_frame);
		if (savedInstanceState == null) {
			FragmentTransaction t = this.getSupportFragmentManager()
					.beginTransaction();
			leftMenuFragment = new LeftMenuFragment();
			t.replace(R.id.menu_frame, leftMenuFragment);
			t.commit();
		} else {
			leftMenuFragment = (LeftMenuFragment) this
					.getSupportFragmentManager()
					.findFragmentById(R.id.menu_frame);
		}

		// customize the SlidingMenu
		leftSlideMenu = getSlidingMenu();
		leftSlideMenu.setShadowWidthRes(R.dimen.shadow_width);
		leftSlideMenu.setShadowDrawable(R.drawable.shadow);
		leftSlideMenu.setBehindOffsetRes(R.dimen.slidingmenu_offset);
		leftSlideMenu.setFadeDegree(0.35f);
		leftSlideMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		getSlidingMenu().setMode(SlidingMenu.LEFT_RIGHT);
		getSlidingMenu().setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		//		setContentView(R.layout.content_frame);
		//		getSupportFragmentManager()
		//				.beginTransaction()
		//				.replace(R.id.content_frame, new LeftMenuFragment())
		//				.commit();

		rightSlideMenu = getSlidingMenu();
		rightSlideMenu.setSecondaryMenu(R.layout.menu_frame_two);
		rightSlideMenu.setSecondaryShadowDrawable(R.drawable.shadowright);
		getSupportFragmentManager()
				.beginTransaction()
				.replace(R.id.menu_frame_two, new RightMenuFragment())
				.commit();
		// configure the SlidingMenu
		//		slideMenu = new SlidingMenu(this);
		//		slideMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		//		slideMenu.setShadowWidthRes(R.dimen.shadow_width);
		//		slideMenu.setShadowDrawable(R.drawable.slidemenu_shadow);
		//		slideMenu.setBehindOffsetRes(R.dimen.slidingmenu_offset);
		//		slideMenu.setFadeDegree(0.35f);
		//		slideMenu.attachToActivity(this, SlidingMenu.SLIDING_CONTENT);
		//		slideMenu.setMenu(R.layout.menu_frame);
		//		getFragmentManager().beginTransaction()
		//				.replace(R.id.menu_frame, new RightMenuFragment()).commit();
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
					leftSlideMenu.toggle();
				else if (v == btnTitleBarBack)
					getFragmentManager()
							.popBackStack();
				else if (v == btnTitleBarAdd) {
					changeFragment(new StartNewGameFragment(), true);
				} else if (v == btnTitleBarMsg) {
					rightSlideMenu.toggle();
				}
			}
		};
		btnTitleBarList.setOnClickListener(mOnClickListener);
		btnTitleBarBack.setOnClickListener(mOnClickListener);
		btnTitleBarAdd.setOnClickListener(mOnClickListener);
		btnTitleBarMsg.setOnClickListener(mOnClickListener);
	}

	@Override
	public void onBackPressed() {
		if (leftSlideMenu.isMenuShowing())
			leftSlideMenu.toggle();
		else if (rightSlideMenu.isMenuShowing())
			rightSlideMenu.toggle();
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
		FragmentTransaction mFragmentTransaction = getSupportFragmentManager()
				.beginTransaction();
		mFragmentTransaction
				.replace(R.id.flyt_content, fragment);
		if (isAddToBackStack)
			mFragmentTransaction.addToBackStack(null);
		mFragmentTransaction.commit();
	}
}