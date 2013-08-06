package com.engagemobile.vsfootball.fragment;

import com.engagemobile.vsfootball.activity.MainActivity;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * * This is a Superclass inherits from Fragment, All other classes inherit from
 * this Fragment.
 * 
 * @author xiaoyuanhu
 */
public class VsFootballFragment extends Fragment {
	MainActivity activityParent;
	Context mContext;
	private static String TAG="VsFootballFragment :===================: ";
	@Override
	public void onCreate(Bundle savedInstanceState) {
		activityParent = (MainActivity) this.getActivity();
		mContext = this.getActivity();
		super.onCreate(savedInstanceState);
	}
	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		Log.i(TAG, "onActivityCreated");
		super.onActivityCreated(savedInstanceState);
	}
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		Log.i(TAG, "onCreateView");
		return super.onCreateView(inflater, container, savedInstanceState);
	}
	@Override
	public void onDestroy() {
		Log.i(TAG, "onDestroy");
		super.onDestroy();
	}
	@Override
	public void onDestroyView() {
		Log.i(TAG, "onDestroyView");
		super.onDestroyView();
	}
	@Override
	public void onDetach() {
		Log.i(TAG, "onDetach");
		super.onDetach();
	}
	@Override
	public void onPause() {
		Log.i(TAG, "onPause");
		super.onPause();
	}
	@Override
	public void onResume() {
		Log.i(TAG, "onResume");
		super.onResume();
	}
	@Override
	public void onStart() {
		Log.i(TAG, "onStart");
		super.onStart();
	}
	@Override
	public void onStop() {
		Log.i(TAG, "onStop");
		super.onStop();
	}
}
