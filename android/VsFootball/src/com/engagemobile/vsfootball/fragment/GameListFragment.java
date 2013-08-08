package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Game;
import com.engagemobile.vsfootball.bean.ModelContext;
import com.engagemobile.vsfootball.net.GameService;
import com.engagemobile.vsfootball.net.NetException;
import com.engagemobile.vsfootball.net.bean.GameListResult;
import com.engagemobile.vsfootball.net.bean.Response;
import com.engagemobile.vsfootball.utils.ListViewUtil;
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
	private static GameListFragment instance;
	private List<Game> mGame = new ArrayList<Game>();

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		// mockData();
		instance = this;
	}

	/*	private void mockData() {
			// TODO Auto-generated method stub
			List<String> listYourTurn = new ArrayList<String>();
			listYourTurn.add("D-CLAW vs.Favre Dollor Ftlong");
			listYourTurn.add("Sproles Royce vs. D-CLAW");
			mAdapterYourTurn = new GameAdapter(mContext, listYourTurn);
			List<String> listTheirTurn = new ArrayList<String>();
			listTheirTurn.add("D-CLAW vs.RG-3PO");
			listTheirTurn.add("D-CLAW vs.Rice Rice Baby");

			mAdapterTheirTurn = new GameAdapter(mContext, listTheirTurn);
			List<String> listCompletedGames = new ArrayList<String>();
			listCompletedGames.add("D-CLAW vs.Rice Rice Baby");
			listCompletedGames.add("Sproles Royce vs. D-CLAW");
			mAdapterCompletedGames = new GameAdapter(mContext, listCompletedGames);
		}*/

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater.inflate(R.layout.fragment_game_list, null);
		mLvYourTurn = (ListView) rootView.findViewById(R.id.lv_your_turn);
		mLvTheirTurn = (ListView) rootView.findViewById(R.id.lv_their_turn);
		mLvCompletedGame = (ListView) rootView
				.findViewById(R.id.lv_completed_games);
		mAdapterYourTurn = new GameAdapter(mContext, mGame);
		mAdapterCompletedGames = new GameAdapter(mContext, mGame);
		mLvYourTurn.setAdapter(mAdapterYourTurn);
		mLvTheirTurn.setAdapter(mAdapterTheirTurn);
		mLvCompletedGame.setAdapter(mAdapterCompletedGames);
		ListViewUtil.setListViewHeightBasedOnChildren(mLvYourTurn);
		ListViewUtil.setListViewHeightBasedOnChildren(mLvTheirTurn);
		ListViewUtil.setListViewHeightBasedOnChildren(mLvCompletedGame);
		OnItemClickListener mOnItemClickListener = new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				if (position % 2 == 0)
					activityParent.isOffensive = true;
				else
					activityParent.isOffensive = false;
				ModelContext.getInstance().setCurrentSelectedGame(
						(Game) parent.getItemAtPosition(position));
				activityParent.changeFragment(new GameSummaryFragment(), true);
			}
		};
		mLvYourTurn.setOnItemClickListener(mOnItemClickListener);
		mLvTheirTurn.setOnItemClickListener(mOnItemClickListener);
		if (mGame.size() == 0) {
			loadGameList();
		}
		return rootView;
	}

	@Override
	public void onResume() {
		activityParent.btnTitleBarAdd.setVisibility(View.VISIBLE);
		activityParent.btnTitleBarMsg.setVisibility(View.GONE);
		activityParent.btnTitleBarList.setVisibility(View.VISIBLE);
		activityParent.btnTitleBarBack.setVisibility(View.GONE);
		super.onResume();
	}

	public static GameListFragment getInstance() {
		return instance;
	}

	private void loadGameList() {
		AsyncTask<String, Integer, Response> loadGameListTask = new AsyncTask<String, Integer, Response>() {

			@Override
			protected void onPreExecute() {
				showProgress(R.string.processing, R.string.loading_game_list);
			}

			@Override
			protected Response doInBackground(String... params) {
				GameService service = new GameService();
				try {
					/*return service.createGame("zxjzerg@gmail.com", "O",
							"Andrew's Team",
							"p1");*/
					return service.getGames(ModelContext.getInstance()
							.getCurrentUser());

				} catch (NetException e) {
					return null;
				}
			}

			protected void onPostExecute(Response response) {
				if (response != null && response.getResponseResult() != null) {
					if (response.getResponseResult().getSuccess()) {
						final List<Game> games = ((GameListResult) response
								.getResponseResult()).getGames();
						getActivity().runOnUiThread(new Runnable() {

							@Override
							public void run() {
								mAdapterYourTurn.setmGameList(games);
								mAdapterYourTurn.notifyDataSetChanged();
								ListViewUtil
										.setListViewHeightBasedOnChildren(mLvYourTurn);
								ListViewUtil
										.setListViewHeightBasedOnChildren(mLvTheirTurn);
								ListViewUtil
										.setListViewHeightBasedOnChildren(mLvCompletedGame);
							}
						});

					} else {
						// error from server
					}
				} else {
					// network error
				}
				dismissProgress();

			}

		};
		loadGameListTask.execute(new String[] {});
	}
}
