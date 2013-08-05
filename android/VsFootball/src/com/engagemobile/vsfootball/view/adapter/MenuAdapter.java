package com.engagemobile.vsfootball.view.adapter;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;

/**
 * This adapter is used for the Game's ListView.
 * 
 * @author xiaoyuanhu
 */
public class MenuAdapter extends BaseAdapter {
	private List<String> mMenuList;
	private Context mContext;

	public MenuAdapter(Context mContext, List<String> mMenuList) {
		super();
		this.mMenuList = mMenuList;
		this.mContext = mContext;
	}

	@Override
	public int getCount() {
		return mMenuList.size();
	}

	@Override
	public Object getItem(int position) {
		return mMenuList.get(position);
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
					R.layout.list_item_menu, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_menu_item);
			convertView.setTag(mViewHolder);
		}
		if (position % 2 == 1)
			((LinearLayout) (mViewHolder.mTextView.getParent()))
					.setBackgroundResource(R.drawable.shape_bg_lighter_blue);
		mViewHolder.mTextView.setText(mMenuList.get(position));
		return convertView;
	}

	final static class ViewHolder {
		TextView mTextView;
	}
}
