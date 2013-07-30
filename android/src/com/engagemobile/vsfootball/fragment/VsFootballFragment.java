package com.engagemobile.vsfootball.fragment;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;

/**
 * * This is a Superclass inherits from Fragment, All other classes inherit from
 * this Fragment.
 * 
 * @author xiaoyuanhu
 */
public class VsFootballFragment extends Fragment {
	Activity activityParent;
	Context mContext;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		activityParent = this.getActivity();
		mContext = this.getActivity();
		super.onCreate(savedInstanceState);
	}
}
