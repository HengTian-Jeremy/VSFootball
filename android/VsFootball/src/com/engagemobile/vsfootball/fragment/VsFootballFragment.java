package com.engagemobile.vsfootball.fragment;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.engagemobile.vsfootball.R;
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
	private AlertDialog mAlertDialog;
	private ProgressDialog mProgressDialog;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		activityParent = (MainActivity) this.getActivity();
		mContext = this.getActivity();
		super.onCreate(savedInstanceState);
	}

	public void showProgress(final int titleId, final int msgId) {
		/*getActivity().runOnUiThread(new Runnable() {

			@Override
			public void run() {
				 activityParent.showProgress(titleId, msgId);
			}
		});*/
		if (mProgressDialog == null) {
			mProgressDialog = new ProgressDialog(getActivity());
		}
		mProgressDialog.setTitle(getString(titleId));
		mProgressDialog.setMessage(getString(msgId));
		mProgressDialog.show();

	}

	public void dismissProgress() {
		/*getActivity().runOnUiThread(new Runnable() {

			@Override
			public void run() {
				activityParent.dismissProgress();
			}
		});*/
		if (mProgressDialog != null) {
			mProgressDialog.dismiss();
		}
	}
	@Override
	public void onResume() {
		activityParent.setTitle(getResources().getString(R.string.title));
		super.onResume();
	}
}
