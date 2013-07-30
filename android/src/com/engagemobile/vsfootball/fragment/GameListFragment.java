package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.view.adapter.GameAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class GameListFragment extends VsFootballFragment {
	private GameAdapter mGameAdapterYour;
	private GameAdapter mGameAdapterOther;
	private ListView mLvYourTurn;
	private ListView mLvOtherTurn;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		mockData();
	}

	private void mockData() {
		// TODO Auto-generated method stub
		List<String> listYourTurn = new ArrayList<String>();
		listYourTurn.add("D-CLAW vs.Favre Dollor Ftlong");
		listYourTurn.add("Sproles Royce vs. D-CLAW");
		listYourTurn.add("D-CLAW vs.Favre Dollor Ftlong");
		listYourTurn.add("Sproles Royce vs. D-CLAW");
		mGameAdapterYour = new GameAdapter(mContext, listYourTurn);
		List<String> listOtherTurn = new ArrayList<String>();
		listOtherTurn.add("D-CLAW vs.Favre Dollor Ftlong");
		listOtherTurn.add("Sproles Royce vs. D-CLAW");
		listOtherTurn.add("D-CLAW vs.Favre Dollor Ftlong");
		listOtherTurn.add("Sproles Royce vs. D-CLAW");
		mGameAdapterOther = new GameAdapter(mContext, listOtherTurn);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_gamelist, null);
		mLvYourTurn = (ListView) rootView.findViewById(R.id.lv_your_turn);
		mLvOtherTurn = (ListView) rootView.findViewById(R.id.lv_other_turn);
		mLvYourTurn.setAdapter(mGameAdapterYour);
		mLvOtherTurn.setAdapter(mGameAdapterOther);
		mLvYourTurn.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				FragmentTransaction mFragmentTransaction = activityParent
						.getFragmentManager()
						.beginTransaction();
				mFragmentTransaction
						.replace(R.id.flyt_content, new GameFragment());
				mFragmentTransaction.addToBackStack(null);
				mFragmentTransaction.commit();
			}
		});
		return rootView;
	}
}
