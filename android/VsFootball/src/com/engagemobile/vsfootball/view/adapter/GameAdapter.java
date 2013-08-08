package com.engagemobile.vsfootball.view.adapter;

import java.util.List;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Game;

/**
 * This adapter is used for the Game's ListView.
 * 
 * @author xiaoyuanhu
 */
public class GameAdapter extends BaseAdapter {
	private List<Game> mGameList;
	private Context mContext;

	public GameAdapter(Context context, List<Game> gameList) {
		super();
		mGameList = gameList;
		mContext = context;
	}

	@Override
	public int getCount() {
		return mGameList.size();
	}

	@Override
	public Object getItem(int position) {
		return mGameList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		Log.d("GameAdapter", "on create posisiton" + position);
		ViewHolder mViewHolder = null;
		if (convertView != null)
			mViewHolder = (ViewHolder) convertView.getTag();
		else {
			mViewHolder = new ViewHolder();
			convertView = LayoutInflater.from(mContext).inflate(
					R.layout.list_item_game, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_game_name);
			convertView.setTag(mViewHolder);
		}
		String gameName = getmGameList().get(position).getPlayer1TeamName()
				+ " VS "
				+ getmGameList().get(position).getPlayer2TeamName();
		mViewHolder.mTextView.setText(gameName);
		return convertView;
	}

	public List<Game> getmGameList() {
		return mGameList;
	}

	public void setmGameList(List<Game> mGameList) {
		this.mGameList = mGameList;
	}

	final static class ViewHolder {
		TextView mTextView;
	}
}
