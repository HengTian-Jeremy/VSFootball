package com.engagemobile.vsfootball.activity;

import java.util.ArrayList;
import java.util.List;

import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentManager.OnBackStackChangedListener;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.fragment.FeedbackFragment;
import com.engagemobile.vsfootball.fragment.GameListFragment;
import com.engagemobile.vsfootball.fragment.GameSummaryFragment;
import com.engagemobile.vsfootball.fragment.LeftMenuFragment;
import com.engagemobile.vsfootball.fragment.NewGameContactFragment;
import com.engagemobile.vsfootball.fragment.NewGameEmailFragment;
import com.engagemobile.vsfootball.fragment.NewGameFacebookFriendsFragment;
import com.engagemobile.vsfootball.fragment.NewGameOptionsFragment;
import com.engagemobile.vsfootball.fragment.PlayAnimationFragment;
import com.engagemobile.vsfootball.fragment.PlayComboFragment;
import com.engagemobile.vsfootball.fragment.PlayOutcomeFragment;
import com.engagemobile.vsfootball.fragment.PlaySelectionFragment;
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
	private ImageButton btnTitleBarList;
	private ImageButton btnTitleBarAdd;
	private Button btnTitleBarBack;
	private ImageButton btnTitleBarMsg;
	private TextView tvTitleBarTitle;
	public boolean isOffensive;
	public Fragment curFragment;
	private RelativeLayout rlytTitleBar;
	private TextView tvAd;
	private LeftMenuFragment leftMenuFragment;
	public SlidingMenu slideMenu;
	public String opponnentName;
	private FragmentManager fragmentManager;
	private boolean isBacking;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		fragmentManager = this.getSupportFragmentManager();
		findViewById();
		initSlidingMenu(savedInstanceState);
		addListener();
		curFragment = new GameListFragment();
		fragmentManager.beginTransaction()
				.replace(R.id.flyt_content, curFragment).commit();
	}

	private void findViewById() {
		btnTitleBarList = (ImageButton) findViewById(R.id.ibtn_titlebar_show_navi_list);
		btnTitleBarAdd = (ImageButton) findViewById(R.id.ibtn_titlebar_add);
		btnTitleBarBack = (Button) findViewById(R.id.btn_titlebar_back);
		tvTitleBarTitle = (TextView) findViewById(R.id.tv_titlebar_title);
		Typeface font = Typeface.createFromAsset(getAssets(),
				"fonts/SketchRockwell.ttf");
		tvTitleBarTitle.setTypeface(font);
		btnTitleBarMsg = (ImageButton) findViewById(R.id.ibtn_titlebar_msg);
		tvAd = (TextView) findViewById(R.id.tv_ad);
		rlytTitleBar = (RelativeLayout) findViewById(R.id.rlyt_title);
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
					.getSupportFragmentManager().findFragmentById(
							R.id.menu_frame);
		}

		// customize the SlidingMenu
		slideMenu = getSlidingMenu();
		slideMenu.setShadowWidthRes(R.dimen.shadow_width);
		slideMenu.setShadowDrawable(R.drawable.shadow);
		slideMenu.setBehindOffsetRes(R.dimen.slidingmenu_offset);
		slideMenu.setFadeDegree(0.35f);
		slideMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		getSlidingMenu().setMode(SlidingMenu.LEFT_RIGHT);
		getSlidingMenu().setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		// setContentView(R.layout.content_frame);
		// getSupportFragmentManager()
		// .beginTransaction()
		// .replace(R.id.content_frame, new LeftMenuFragment())
		// .commit();

		slideMenu.setSecondaryMenu(R.layout.menu_frame_two);
		slideMenu.setSecondaryShadowDrawable(R.drawable.shadowright);
		getSupportFragmentManager().beginTransaction()
				.replace(R.id.menu_frame_two, new RightMenuFragment()).commit();
		// configure the SlidingMenu
		// slideMenu = new SlidingMenu(this);
		// slideMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		// slideMenu.setShadowWidthRes(R.dimen.shadow_width);
		// slideMenu.setShadowDrawable(R.drawable.slidemenu_shadow);
		// slideMenu.setBehindOffsetRes(R.dimen.slidingmenu_offset);
		// slideMenu.setFadeDegree(0.35f);
		// slideMenu.attachToActivity(this, SlidingMenu.SLIDING_CONTENT);
		// slideMenu.setMenu(R.layout.menu_frame);
		// getFragmentManager().beginTransaction()
		// .replace(R.id.menu_frame, new RightMenuFragment()).commit();
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
				else if (v == btnTitleBarBack) {
					isBacking = true;
					getSupportFragmentManager()
							.popBackStack();
				}
				else if (v == btnTitleBarAdd) {
					switchFragment(new StartNewGameFragment(), true);
				} else if (v == btnTitleBarMsg) {
					if (!slideMenu.isSecondaryMenuShowing())
						slideMenu.showSecondaryMenu();
					else
						slideMenu.toggle();
				}
			}
		};
		btnTitleBarList.setOnClickListener(mOnClickListener);
		btnTitleBarBack.setOnClickListener(mOnClickListener);
		btnTitleBarAdd.setOnClickListener(mOnClickListener);
		btnTitleBarMsg.setOnClickListener(mOnClickListener);
		fragmentManager
				.addOnBackStackChangedListener(new OnBackStackChangedListener() {

					@Override
					public void onBackStackChanged() {
						// TODO Auto-generated method stub
						if (isBacking) {
							Fragment fragment = fragmentManager
									.findFragmentById(R.id.flyt_content);
							updateFragmentTitle(fragment);
							isBacking = false;
						}
					}
				});
	}

	@Override
	public void onBackPressed() {
		if (btnTitleBarBack.getVisibility() == View.VISIBLE
				&& rlytTitleBar.getVisibility() == View.VISIBLE) {
			isBacking = true;
			getSupportFragmentManager()
					.popBackStack();
		}
	}

	public void switchFragment(Fragment fragment,
			boolean isAddToBackStack) {
		updateFragmentTitle(fragment);
		if (curFragment != fragment) {
			FragmentTransaction transaction = fragmentManager
					.beginTransaction().setCustomAnimations(
							R.anim.fragment_slide_right_enter,
							R.anim.fragment_slide_left_exit,
							R.anim.fragment_slide_left_enter,
							R.anim.fragment_slide_right_exit);
			if (!fragment.isAdded()) {
				transaction.hide(curFragment).add(R.id.flyt_content, fragment);
			} else {
				transaction.hide(curFragment).show(fragment);
			}
			//			if (isAddToBackStack) {
			transaction.addToBackStack(null);
			//			} else {
			//			}
			transaction.commit();
			curFragment = fragment;
		}
	}

	private void isShowAdOrTitle(boolean isShowTitle, boolean isShowAd) {
		setViewVisbility(isShowAd, tvAd);
		setViewVisbility(isShowTitle, rlytTitleBar);
	}

	private void updateFragmentTitle(Fragment fragment) {
		if (fragment instanceof FeedbackFragment) {
			updateTitleBar(true, false, false, false, null);
			isShowAdOrTitle(true, true);

		} else if (fragment instanceof GameListFragment) {
			updateTitleBar(true, false, true, false, null);
			isShowAdOrTitle(true, true);

		} else if (fragment instanceof GameSummaryFragment) {
			updateTitleBar(true, false, false, true, null);
			isShowAdOrTitle(true, true);
		} else if (fragment instanceof NewGameContactFragment) {
			updateTitleBar(false, true, false, false, "Contacts");
			isShowAdOrTitle(true, true);
		} else if (fragment instanceof NewGameEmailFragment) {
			isShowAdOrTitle(false, false);
		} else if (fragment instanceof NewGameFacebookFriendsFragment) {
			updateTitleBar(false, true, false, false, "Facebook friends");
			isShowAdOrTitle(true, false);
		} else if (fragment instanceof NewGameOptionsFragment) {
			updateTitleBar(false, false, false, false, null);
			isShowAdOrTitle(true, true);
		} else if (fragment instanceof PlayAnimationFragment) {
			isShowAdOrTitle(false, false);
		} else if (fragment instanceof PlayComboFragment) {
			updateTitleBar(false, false, false, false, null);
			isShowAdOrTitle(true, true);
		} else if (fragment instanceof PlayOutcomeFragment) {
			updateTitleBar(true, false, false, false, null);
			isShowAdOrTitle(true, true);
		} else if (fragment instanceof PlaySelectionFragment) {
			updateTitleBar(false, true, false, false, "Offensive");
			isShowAdOrTitle(true, true);
		} else if (fragment instanceof StartNewGameFragment) {
			updateTitleBar(false, true, false, false, "Start a Game");
			isShowAdOrTitle(true, true);
		}
	}

	private void updateTitleBar(boolean isList, boolean isBack, boolean isAdd,
			boolean isMsg, String title) {
		setViewVisbility(isList, btnTitleBarList);
		setViewVisbility(isBack, btnTitleBarBack);
		setViewVisbility(isAdd, btnTitleBarAdd);
		setViewVisbility(isMsg, btnTitleBarMsg);
		if (title != null)
			tvTitleBarTitle.setText(title);
		else
			tvTitleBarTitle.setText(getResources().getString(R.string.title));
		if (isList && isMsg) {
			slideMenu.setSlidingEnabled(true);
			slideMenu.setMode(SlidingMenu.LEFT_RIGHT);
		} else if (isList) {
			slideMenu.setSlidingEnabled(true);
			slideMenu.setMode(SlidingMenu.LEFT);
		} else if (isMsg) {
			slideMenu.setSlidingEnabled(true);
			slideMenu.setMode(SlidingMenu.RIGHT);
		} else {
			slideMenu.setSlidingEnabled(false);
		}
	}

	private void setViewVisbility(boolean isShow, View v) {
		if (isShow)
			v.setVisibility(View.VISIBLE);
		else
			v.setVisibility(View.GONE);
	}
}