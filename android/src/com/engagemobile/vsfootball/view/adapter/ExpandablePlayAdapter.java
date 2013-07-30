package com.engagemobile.vsfootball.view.adapter;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.Play;

/**
 * This adapter is used for the play's ListView.
 * 
 * @author xiaoyuanhu
 */
public class ExpandablePlayAdapter extends BaseAdapter {
	private List<Play> mPlayList;
	private Context mContext;

	public ExpandablePlayAdapter(Context mContext, List<Play> mPlayList) {
		super();
		this.mPlayList = mPlayList;
		this.mContext = mContext;
	}

	@Override
	public int getCount() {
		return mPlayList.size();
	}

	@Override
	public Object getItem(int position) {
		return mPlayList.get(position);
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
					R.layout.list_item_expandable_play, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_play_name);
			mViewHolder.mButton = (Button) convertView
					.findViewById(R.id.expandable_toggle_button);
			convertView.setTag(mViewHolder);
		}
		mViewHolder.mTextView.setText(mPlayList.get(position).getName());
		mViewHolder.mButton.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO button click event
			}
		});
		return convertView;
	}

	final static class ViewHolder {
		TextView mTextView;
		Button mButton;
	}
}
