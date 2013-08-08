package com.engagemobile.vsfootball.fragment;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.engagemobile.vsfootball.activity.MainActivity;

/**
 * * This is a Superclass inherits from Fragment, All other classes inherit from
 * this Fragment.
 * 
 * @author xiaoyuanhu
 */
public class VsFootballFragment extends Fragment {
	MainActivity activityParent;
	Context mContext;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		activityParent = (MainActivity) this.getActivity();
		mContext = this.getActivity();
		super.onCreate(savedInstanceState);
	}
}
