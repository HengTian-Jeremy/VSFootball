package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.ListView;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.LoginActivity;
import com.engagemobile.vsfootball.utils.ListViewUtil;
import com.engagemobile.vsfootball.view.adapter.MenuAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class RightMenuFragment extends VsFootballFragment {
	private LinearLayout mLlytMsgs;
	private String s1 = "If I had something clever to say, it would go here!;)";
	private String s2 = "Wait untiil next time around...)";

	@Override
	public void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		mockData();
	}

	private void mockData() {
		// TODO Auto-generated method stub
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater
				.inflate(R.layout.fragment_right_slid_menu, null);
		mLlytMsgs = (LinearLayout) rootView
				.findViewById(R.id.llyt_right_slid_msgs);
		setTextView(s1);
		return rootView;
	}

	private void setTextView(String s) {
		TextView t = new TextView(mContext);
		LayoutParams params = new LayoutParams(LayoutParams.MATCH_PARENT,
				LayoutParams.WRAP_CONTENT);
		params.setMargins(0,
				(int) getResources().getDimension(R.dimen.msg_margin_top), 0, 0);
		t.setLayoutParams(params);
		t.setText(s);
		t.setTextSize(20);
		t.setBackgroundResource(R.drawable.shape_black_frame_grey);
		mLlytMsgs.addView(t);
	}
}
