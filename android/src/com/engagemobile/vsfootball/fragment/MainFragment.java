package com.engagemobile.vsfootball.fragment;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SlidingDrawer;
import android.widget.SlidingDrawer.OnDrawerCloseListener;
import android.widget.SlidingDrawer.OnDrawerOpenListener;
import com.engagemobile.vsfootball.R;
/**
 * This is the main fragment in MainActivity.
 * @author xiaoyuanhu
 *
 */
public class MainFragment extends Fragment {
	private SlidingDrawer mDrawerScoreboard;
	private ImageView mTouchImage;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_home, null);
		mDrawerScoreboard = (SlidingDrawer) rootView
				.findViewById(R.id.scoreboard_drawer);
		mTouchImage = (ImageView) rootView.findViewById(R.id.touch_image);
		mDrawerScoreboard.setOnDrawerOpenListener(new OnDrawerOpenListener() {
			public void onDrawerOpened() {
				//TODO Auto-generated method stub

			}
		});
		mDrawerScoreboard.setOnDrawerCloseListener(new OnDrawerCloseListener() {

			public void onDrawerClosed() {
				//TODO Auto-generated method stubv
			}
		});
		return rootView;
	}
}
