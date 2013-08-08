package com.engagemobile.vsfootball.view.adapter;

import java.util.List;

import android.app.AlertDialog;
import android.app.FragmentTransaction;
import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.activity.MainActivity;
import com.engagemobile.vsfootball.bean.Play;
import com.engagemobile.vsfootball.fragment.PlayComboFragment;
import com.engagemobile.vsfootball.fragment.PlaySelectionFragment;

/**
 * This adapter is used for the play's ListView.
 * 
 * @author xiaoyuanhu
 */
public class ExpandablePlayAdapter extends BaseExpandableListAdapter {
	private List<Play> mPlayList;
	private Context mContext;
	private MainActivity activityParent;

	public List<Play> getmPlayList() {
		return mPlayList;
	}

	public void setmPlayList(List<Play> mPlayList) {
		this.mPlayList = mPlayList;
	}

	public ExpandablePlayAdapter(Context mContext, List<Play> mPlayList,
			MainActivity activityParent) {
		super();
		this.mPlayList = mPlayList;
		this.mContext = mContext;
		this.activityParent = activityParent;
	}

	final static class ViewHolder {
		TextView mTextView;
		//		Button mButton;
		ImageView mImageView;
	}

	@Override
	public int getGroupCount() {
		// TODO Auto-generated method stub
		return mPlayList.size();
	}

	@Override
	public int getChildrenCount(int groupPosition) {
		// TODO Auto-generated method stub
		return 1;
	}

	@Override
	public Object getGroup(int groupPosition) {
		// TODO Auto-generated method stub
		return mPlayList.get(groupPosition);
	}

	@Override
	public Object getChild(int groupPosition, int childPosition) {
		// TODO Auto-generated method stub
		return mPlayList.get(groupPosition).getResourceId();
	}

	@Override
	public long getGroupId(int groupPosition) {
		// TODO Auto-generated method stub
		return groupPosition;
	}

	@Override
	public long getChildId(int groupPosition, int childPosition) {
		// TODO Auto-generated method stub
		return childPosition;
	}

	@Override
	public boolean hasStableIds() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public View getGroupView(int groupPosition, boolean isExpanded,
			View convertView, ViewGroup parent) {
		// TODO Auto-generated method stub
		ViewHolder mViewHolder = null;
		if (convertView != null)
			mViewHolder = (ViewHolder) convertView.getTag();
		else {
			mViewHolder = new ViewHolder();
			convertView = LayoutInflater.from(mContext).inflate(
					R.layout.list_item_expandable_play, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_play_name);
			mViewHolder.mImageView = (ImageView) convertView
					.findViewById(R.id.iv_play_detail);
			convertView.setTag(mViewHolder);
		}
		if (isExpanded)
			((RelativeLayout) mViewHolder.mTextView.getParent())
					.setBackgroundResource(R.drawable.shape_black_frame_selected);
		else
			((RelativeLayout) mViewHolder.mTextView.getParent())
					.setBackgroundResource(R.drawable.shape_bg);
		mViewHolder.mTextView.setText(mPlayList.get(groupPosition).getName());
		mViewHolder.mImageView.setBackgroundResource(mPlayList.get(
				groupPosition).getResourceId());
		return convertView;
	}

	@Override
	public View getChildView(int groupPosition, int childPosition,
			boolean isLastChild, View convertView, ViewGroup parent) {
		// TODO Auto-generated method stub
		LayoutInflater layoutInflater = (LayoutInflater) mContext
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

		//获取二级列表对应的布局文件, 并将其各元素设置相应的属性
		LinearLayout linearLayout = (LinearLayout) layoutInflater.inflate(
				R.layout.list_item_expandable_detail, null);
		ImageView iv = (ImageView) linearLayout.findViewById(R.id.iv_detail);
		iv.setBackgroundResource(mPlayList.get(
				groupPosition).getResourceId());
		final int index = groupPosition;
		iv.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				new AlertDialog.Builder(mContext)
						.setTitle(
								activityParent
										.getResources()
										.getString(
												R.string.dialog_play_confirmation_title))
						.setMessage(
								activityParent
										.getResources()
										.getString(
												R.string.dialog_play_confirmation_message,
												(mPlayList.get(index).getName())))
						.setPositiveButton(
								(activityParent.getResources()
										.getString(R.string.string_yes)),
								new DialogInterface.OnClickListener() {

									@Override
									public void onClick(DialogInterface dialog,
											int which) {
										// TODO Auto-generated method stub
										activityParent.changeFragment(
												new PlayComboFragment(), true);
									}
								})
						.setNegativeButton(
								(activityParent.getResources()
										.getString(R.string.string_no)),
								new DialogInterface.OnClickListener() {

									@Override
									public void onClick(DialogInterface dialog,
											int which) {
										// TODO Auto-generated method stub
										dialog.dismiss();
									}
								}).show();
			}
		});
		return linearLayout;
	}

	@Override
	public boolean isChildSelectable(int groupPosition, int childPosition) {
		// TODO Auto-generated method stub
		return true;
	}
}
