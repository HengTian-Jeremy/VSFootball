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
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.fragment.NewGameOptionsFragment;

/**
 * This adapter is used for the Game's ListView.
 * 
 * @author xiaoyuanhu
 */
public class PreOpponentsAdapter extends BaseAdapter {
	private List<String> mGameList;
	private Context mContext;
	private MainActivity mActivity;

	public PreOpponentsAdapter(Context mContext, List<String> mGameList,
			MainActivity mActivity) {
		super();
		this.mGameList = mGameList;
		this.mContext = mContext;
		this.mActivity = mActivity;
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
					R.layout.list_item_pre_opponents, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_pre_opponents);
			mViewHolder.mButton = (Button) convertView
					.findViewById(R.id.btn_pre_opponents);
			convertView.setTag(mViewHolder);
		}
		mViewHolder.mTextView.setText(mGameList.get(position));
		final int index = position;
		mViewHolder.mButton.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				mActivity.opponnentName = mGameList.get(index);
				mActivity.switchFragment(new NewGameOptionsFragment(), true);
			}
		});
		return convertView;
	}

	final static class ViewHolder {
		TextView mTextView;
		Button mButton;
	}
}
