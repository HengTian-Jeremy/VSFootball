package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.view.adapter.GameAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class GameListFragment extends Fragment {
	private GameAdapter mGameAdapterYour;
	private GameAdapter mGameAdapterOther;
	private ListView mLvYourTurn;
	private ListView mLvOtherTurn;
	private Context mContext;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		mContext = this.getActivity();
		mockData();
		super.onCreate(savedInstanceState);
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
		return rootView;
	}
}
