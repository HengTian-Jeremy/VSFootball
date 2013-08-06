package com.engagemobile.vsfootball.view.adapter;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;

/**
 * This adapter is used for the Game's ListView.
 * @author xiaoyuanhu
 *
 */
public class NewOpponentsAdapter extends BaseAdapter {
	private List<String> mGameList;
	private Context mContext;

	public NewOpponentsAdapter(Context mContext, List<String> mGameList) {
		super();
		this.mGameList = mGameList;
		this.mContext = mContext;
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
		ViewHolder mViewHolder = null;
		if (convertView != null)
			mViewHolder = (ViewHolder) convertView.getTag();
		else {
			mViewHolder = new ViewHolder();
			convertView = LayoutInflater.from(mContext).inflate(
					R.layout.list_item_new_opponents, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_new_opponents);
			convertView.setTag(mViewHolder);
		}
		mViewHolder.mTextView.setText(mGameList.get(position));
		return convertView;
	}
	final static class ViewHolder {
		TextView mTextView;
	}
}
