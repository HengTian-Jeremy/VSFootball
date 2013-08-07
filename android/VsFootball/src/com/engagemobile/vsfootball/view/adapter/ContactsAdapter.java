package com.engagemobile.vsfootball.view.adapter;

import java.util.List;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.SectionIndexer;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.MyContacts;

/**
 * This adapter is used for the Game's ListView.
 * 
 * @author xiaoyuanhu
 */
public class ContactsAdapter extends BaseAdapter implements SectionIndexer {
	private List<MyContacts> mListContacts;
	private Context mContext;

	public ContactsAdapter(Context mContext, List<MyContacts> mListContacts) {
		super();
		this.mListContacts = mListContacts;
		this.mContext = mContext;
	}

	@Override
	public int getCount() {
		return mListContacts.size();
	}

	@Override
	public Object getItem(int position) {
		return mListContacts.get(position);
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
					R.layout.list_item_contacts, null);
			mViewHolder.mTextView = (TextView) convertView
					.findViewById(R.id.tv_contacts_name);
			convertView.setTag(mViewHolder);
		}
		mViewHolder.mTextView.setText(mListContacts.get(position)
				.getName());
		return convertView;
	}

	final static class ViewHolder {
		TextView mTextView;
	}

	public static String converterToFirstSpell(String chines) {
		String pinyinName = "";
		chines = chines.replaceAll("(?i)[^a-zA-Z0-9\u4E00-\u9FA5]", "");
		char[] nameChar = chines.toCharArray();
		HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
		defaultFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);
		defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		for (int i = 0; i < nameChar.length; i++) {
			if (nameChar[i] > 128) {
				try {
					pinyinName += PinyinHelper.toHanyuPinyinStringArray(
							nameChar[i], defaultFormat)[0].charAt(0);
				} catch (BadHanyuPinyinOutputFormatCombination e) {
					e.printStackTrace();
				}
			} else {
				pinyinName += nameChar[i];
			}
		}
		return pinyinName;
	}

	@Override
	public Object[] getSections() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPositionForSection(int section) {
		// TODO Auto-generated method stub
		char alpha;
		if (section == 35) {
			return 0;
		}
		Log.e("debug", "" + section);
		for (int i = 0; i < mListContacts.size(); i++) {
			MyContacts myContacts= mListContacts.get(i);
			String nick = myContacts.getName().toUpperCase();
			if (nick.length() >= 1) {
				alpha = nick.charAt(0);
				if (alpha == section) {
					return i  ;
				}
			}
		}
		return -1;
	}

	@Override
	public int getSectionForPosition(int position) {
		// TODO Auto-generated method stub
		return 0;
	}
}
