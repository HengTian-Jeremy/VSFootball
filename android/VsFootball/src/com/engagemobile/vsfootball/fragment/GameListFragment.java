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
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.view.adapter.GameAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class GameListFragment extends VsFootballFragment {
	private GameAdapter mAdapterYourTurn;
	private GameAdapter mAdapterTheirTurn;
	private GameAdapter mAdapterCompletedGames;
	private ListView mLvYourTurn;
	private ListView mLvTheirTurn;
	private ListView mLvCompletedGame;

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
		mAdapterYourTurn = new GameAdapter(mContext, listYourTurn);
		List<String> listTheirTurn = new ArrayList<String>();
		listTheirTurn.add("D-CLAW vs.Favre Dollor Ftlong");
		listTheirTurn.add("Sproles Royce vs. D-CLAW");
		listTheirTurn.add("D-CLAW vs.Favre Dollor Ftlong");
		listTheirTurn.add("Sproles Royce vs. D-CLAW");
		mAdapterTheirTurn = new GameAdapter(mContext, listTheirTurn);
		List<String> listCompletedGames = new ArrayList<String>();
		listCompletedGames.add("D-CLAW vs.Favre Dollor Ftlong");
		listCompletedGames.add("Sproles Royce vs. D-CLAW");
		listCompletedGames.add("D-CLAW vs.Favre Dollor Ftlong");
		listCompletedGames.add("Sproles Royce vs. D-CLAW");
		mAdapterCompletedGames = new GameAdapter(mContext, listCompletedGames);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		View rootView = inflater.inflate(R.layout.fragment_game_list, null);
		mLvYourTurn = (ListView) rootView.findViewById(R.id.lv_your_turn);
		mLvTheirTurn = (ListView) rootView.findViewById(R.id.lv_their_turn);
		mLvCompletedGame = (ListView) rootView
				.findViewById(R.id.lv_completed_games);
		mLvYourTurn.setAdapter(mAdapterYourTurn);
		mLvTheirTurn.setAdapter(mAdapterTheirTurn);
		mLvCompletedGame.setAdapter(mAdapterCompletedGames);
		OnItemClickListener mOnItemClickListener = new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				if (position % 2 == 0)
					activityParent.isOffensive = true;
				else
					activityParent.isOffensive = false;
				FragmentTransaction mFragmentTransaction = activityParent
						.getFragmentManager()
						.beginTransaction();
				mFragmentTransaction
						.replace(R.id.flyt_content, new GameSummaryFragment());
				mFragmentTransaction.addToBackStack(null);
				mFragmentTransaction.commit();
			}
		};
		mLvYourTurn.setOnItemClickListener(mOnItemClickListener);
		mLvTheirTurn.setOnItemClickListener(mOnItemClickListener);
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.mBtnTitleBarAdd.setVisibility(View.VISIBLE);
		activityParent.mBtnTitleBarMsg.setVisibility(View.GONE);
		activityParent.mBtnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.mBtnTitleBarBack.setVisibility(View.GONE);
		super.onResume();
	}
}
