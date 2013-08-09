package com.engagemobile.vsfootball.fragment;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.database.Cursor;
import android.os.Bundle;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.engagemobile.vsfootball.R;
import com.engagemobile.vsfootball.bean.MyContacts;
import com.engagemobile.vsfootball.view.SideBar;
import com.engagemobile.vsfootball.view.adapter.ContactsAdapter;

/**
 * This is the main fragment in MainActivity.
 * 
 * @author xiaoyuanhu
 */
public class NewGameContactFragment extends VsFootballFragment {
	//	private Button button;
	private TextView mTvSlidBar;
	private ListView mLvContact;
	private List<MyContacts> mListContact = null;
	private List<MyContacts> mListSearch = null;
	private EditText mEtSearch;
	private ImageView mIvbtnClearSearch;
	private ContactsAdapter mAdapter;
	static String[] pinyin = { "a", "ai", "an", "ang", "ao", "ba", "bai",
			"ban", "bang",
			"bao", "bei", "ben", "beng", "bi", "bian", "biao", "bie", "bin",
			"bing", "bo", "bu", "ca", "cai", "can", "cang", "cao", "ce",
			"ceng", "cha", "chai", "chan", "chang", "chao", "che", "chen",
			"cheng", "chi", "chong", "chou", "chu", "chuai", "chuan",
			"chuang", "chui", "chun", "chuo", "ci", "cong", "cou", "cu",
			"cuan", "cui", "cun", "cuo", "da", "dai", "dan", "dang", "dao",
			"de", "deng", "di", "dian", "diao", "die", "ding", "diu", "dong",
			"dou", "du", "duan", "dui", "dun", "duo", "e", "en", "er", "fa",
			"fan", "fang", "fei", "fen", "feng", "fo", "fou", "fu", "ga",
			"gai", "gan", "gang", "gao", "ge", "gei", "gen", "geng", "gong",
			"gou", "gu", "gua", "guai", "guan", "guang", "gui", "gun", "guo",
			"ha", "hai", "han", "hang", "hao", "he", "hei", "hen", "heng",
			"hong", "hou", "hu", "hua", "huai", "huan", "huang", "hui", "hun",
			"huo", "ji", "jia", "jian", "jiang", "jiao", "jie", "jin", "jing",
			"jiong", "jiu", "ju", "juan", "jue", "jun", "ka", "kai", "kan",
			"kang", "kao", "ke", "ken", "keng", "kong", "kou", "ku", "kua",
			"kuai", "kuan", "kuang", "kui", "kun", "kuo", "la", "lai", "lan",
			"lang", "lao", "le", "lei", "leng", "li", "lia", "lian", "liang",
			"liao", "lie", "lin", "ling", "liu", "long", "lou", "lu", "lv",
			"luan", "lue", "lun", "luo", "ma", "mai", "man", "mang", "mao",
			"me", "mei", "men", "meng", "mi", "mian", "miao", "mie", "min",
			"ming", "miu", "mo", "mou", "mu", "na", "nai", "nan", "nang",
			"nao", "ne", "nei", "nen", "neng", "ni", "nian", "niang", "niao",
			"nie", "nin", "ning", "niu", "nong", "nu", "nv", "nuan", "nue",
			"nuo", "o", "ou", "pa", "pai", "pan", "pang", "pao", "pei", "pen",
			"peng", "pi", "pian", "piao", "pie", "pin", "ping", "po", "pu",
			"qi", "qia", "qian", "qiang", "qiao", "qie", "qin", "qing",
			"qiong", "qiu", "qu", "quan", "que", "qun", "ran", "rang", "rao",
			"re", "ren", "reng", "ri", "rong", "rou", "ru", "ruan", "rui",
			"run", "ruo", "sa", "sai", "san", "sang", "sao", "se", "sen",
			"seng", "sha", "shai", "shan", "shang", "shao", "she", "shen",
			"sheng", "shi", "shou", "shu", "shua", "shuai", "shuan", "shuang",
			"shui", "shun", "shuo", "si", "song", "sou", "su", "suan", "sui",
			"sun", "suo", "ta", "tai", "tan", "tang", "tao", "te", "teng",
			"ti", "tian", "tiao", "tie", "ting", "tong", "tou", "tu", "tuan",
			"tui", "tun", "tuo", "wa", "wai", "wan", "wang", "wei", "wen",
			"weng", "wo", "wu", "xi", "xia", "xian", "xiang", "xiao", "xie",
			"xin", "xing", "xiong", "xiu", "xu", "xuan", "xue", "xun", "ya",
			"yan", "yang", "yao", "ye", "yi", "yin", "ying", "yo", "yong",
			"you", "yu", "yuan", "yue", "yun", "za", "zai", "zan", "zang",
			"zao", "ze", "zei", "zen", "zeng", "zha", "zhai", "zhan",
			"zhang", "zhao", "zhe", "zhen", "zheng", "zhi", "zhong", "zhou",
			"zhu", "zhua", "zhuai", "zhuan", "zhuang", "zhui", "zhun", "zhuo",
			"zi", "zong", "zou", "zu", "zuan", "zui", "zun", "zuo" };

	@Override
	public void onCreate(Bundle savedInstanceState) {
		mListContact = new ArrayList<MyContacts>();
		mListSearch = new ArrayList<MyContacts>();
		super.onCreate(savedInstanceState);
		setContactList();
		mAdapter = new ContactsAdapter(mContext, mListContact);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View rootView = inflater
				.inflate(R.layout.fragment_new_game_contact, null);
		mLvContact = (ListView) rootView
				.findViewById(R.id.lv_contact);
		mTvSlidBar = (TextView) rootView
				.findViewById(R.id.tv_sidebar_text);
		mLvContact.setAdapter(mAdapter);
		mEtSearch = (EditText) rootView.findViewById(R.id.edit_search);
		mIvbtnClearSearch = (ImageView) rootView
				.findViewById(R.id.btn_clean_search);
		SideBar.getInstance().setmDialogText(mTvSlidBar);
		SideBar.getInstance().setListView(mLvContact);
		mIvbtnClearSearch.setOnClickListener(new View.OnClickListener() {

			public void onClick(View v) {
				// TODO Auto-generated method stub
				mEtSearch.setText("");
				mIvbtnClearSearch.setVisibility(View.GONE);
				mAdapter.setmListContacts(mListContact);
				mAdapter.isShowNum = false;
				mAdapter.notifyDataSetChanged();
				mLvContact.invalidate();
			}
		});

		mEtSearch.addTextChangedListener(new TextWatcher() {

			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				// TODO Auto-generated method stub
				if (s.length() != 0) {
					mIvbtnClearSearch.setVisibility(View.VISIBLE);
					getSearchUser(s.toString());
					mAdapter.setmListContacts(mListSearch);
					mAdapter.isShowNum = true;
				} else {
					mIvbtnClearSearch.setVisibility(View.GONE);
					mAdapter.setmListContacts(mListContact);
					mAdapter.isShowNum = false;
				}
				mAdapter.notifyDataSetChanged();
				mLvContact.invalidate();
			}

			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
				// TODO Auto-generated method stub
			}

			public void afterTextChanged(Editable s) {
				// TODO Auto-generated method stub
			}
		});

		mLvContact.setOnScrollListener(new AbsListView.OnScrollListener() {

			public void onScrollStateChanged(AbsListView view, int scrollState) {
				// TODO Auto-generated method stub
				InputMethodManager inputMethodManager = (InputMethodManager) activityParent
						.getSystemService(Context.INPUT_METHOD_SERVICE);
				if (inputMethodManager.isActive()) {
					inputMethodManager.hideSoftInputFromWindow(
							mEtSearch.getWindowToken(),
							InputMethodManager.HIDE_NOT_ALWAYS);
				}
			}

			public void onScroll(AbsListView view, int firstVisibleItem,
					int visibleItemCount, int totalItemCount) {
				// TODO Auto-generated method stub

			}
		});
		mLvContact.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				activityParent.opponnentName =
						((MyContacts) ((ContactsAdapter) mLvContact
								.getAdapter())
								.getItem(position))
								.getName();
				new AlertDialog.Builder(mContext)
						.setTitle(
								getResources().getString(
										R.string.dialog_start_game_title))
						.setMessage(
								getResources()
										.getString(
												R.string.dialog_start_game_message,
												((MyContacts) ((ContactsAdapter) mLvContact
														.getAdapter())
														.getItem(position))
														.getName()))
						.setPositiveButton(
								getResources().getString(R.string.string_yes),
								new DialogInterface.OnClickListener() {

									@Override
									public void onClick(DialogInterface dialog,
											int which) {
										// TODO Auto-generated method stub
										switchFragment(
												new NewGameOptionsFragment(),
												true);
									}
								})
						.setNegativeButton(
								getResources().getString(R.string.string_no),
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
		return rootView;
	}

	private void getSearchUser(String condition) {
		mListSearch.clear();
		if (condition == null || condition.equals(""))
			return;
		String[] projection = { Phone.DISPLAY_NAME, Phone.NUMBER,
				Phone.PHOTO_ID, "sort_key" };
		String selection = Phone.NUMBER + " like '%" + condition + "%' or "
				+ Phone.DISPLAY_NAME + " like '%" + condition + "%' or "
				+ "sort_key" + " like '%" + getPYSearchRegExp(condition, "%")
				+ "%'";
		Cursor cur = activityParent.getContentResolver().query(
				Phone.CONTENT_URI, projection,
				selection, null, Phone.DISPLAY_NAME + " COLLATE LOCALIZED ASC");
		cur.moveToFirst();
		while (cur.getCount() > cur.getPosition()) {
			List<String> phoneList = new ArrayList<String>();
			String number = cur.getString(cur.getColumnIndex(Phone.NUMBER));
			String name = cur.getString(cur.getColumnIndex(Phone.DISPLAY_NAME));
			String photo_id = cur.getString(cur.getColumnIndex(Phone.PHOTO_ID));
			String sort_key = cur.getString(cur.getColumnIndex("sort_key"));
			boolean show = true;
			if (isPinYin(condition)) {
				if (containCn(sort_key)) {
					show = pyMatches(sort_key, condition.replaceAll(" ", ""));
				} else {
					String tempCondition = condition.replaceAll(" ", "")
							.toLowerCase();
					String tempName = name.replaceAll(" ", "").toLowerCase();
					if (name != null && tempName.contains(tempCondition))
						show = true;
					else
						show = false;
				}
			}
			System.out.println("is show " + show);

			if (show) {
				phoneList.add(number);
				MyContacts person = new MyContacts(null, name, phoneList);
				add2List(mListSearch, person);
			}
			cur.moveToNext();
		}
		cur.close();
	}

	/**
	 * get Contacts
	 */
	private void setContactList() {
		String[] projection = { Phone.DISPLAY_NAME, Phone.NUMBER,
				Phone.PHOTO_ID };
		Cursor cur = activityParent.getContentResolver().query(
				Phone.CONTENT_URI, projection,
				null, null, Phone.DISPLAY_NAME + " COLLATE LOCALIZED ASC");
		cur.moveToFirst();
		while (cur.getCount() > cur.getPosition()) {
			MyContacts person = new MyContacts();
			List<String> phone = new ArrayList<String>();
			String number = cur.getString(cur.getColumnIndex(Phone.NUMBER));
			String name = cur.getString(cur.getColumnIndex(Phone.DISPLAY_NAME));
			String photo_id = cur.getString(cur.getColumnIndex(Phone.PHOTO_ID));
			person.setName(name);
			phone.add(number);
			person.setListNumber(phone);
			add2List(mListContact, person);
			cur.moveToNext();
		}
		cur.close();
	}

	public void add2List(List<MyContacts> list, MyContacts person) {
		for (int i = 0; i < list.size(); ++i) {
			if (list.get(i).getName().equals(person.getName())) {
				for (int k = 0; k < person.getListNumber().size(); ++k)
					list.get(i).addNumber(person.getListNumber().get(k));
				return;
			}
		}
		list.add(person);
	}

	public String getPYSearchRegExp(String str, String exp) {
		int start = 0;
		String regExp = "";
		str = str.toLowerCase();
		boolean isFirstSpell = true;
		for (int i = 0; i < str.length(); ++i) {
			String tmp = str.substring(start, i + 1);
			isFirstSpell = binSearch(tmp) ? false : true;

			if (isFirstSpell) {
				regExp += str.substring(start, i) + exp;
				start = i;
			} else {
				isFirstSpell = true;
			}

			if (i == str.length() - 1)
				regExp += str.substring(start, i + 1) + exp;
		}
		return regExp;
	}

	public boolean binSearch(String str) {
		int mid = 0;
		int start = 0;
		int end = pinyin.length - 1;

		while (start < end) {
			mid = start + ((end - start) / 2);
			if (pinyin[mid].matches(str + "[a-zA-Z]*"))
				return true;

			if (pinyin[mid].compareTo(str) < 0)
				start = mid + 1;
			else
				end = mid - 1;
		}
		return false;
	}

	public boolean pyMatches(String src, String des) {
		if (src != null) {
			src = src.replaceAll("[^ a-zA-Z]", "").toLowerCase();
			src = src.replaceAll("[ ]+", " ");
			String condition = getPYSearchRegExp(des, "[a-zA-Z]* ");

			/*
			Pattern pattern = Pattern.compile(condition);
			Matcher m = pattern.matcher(src);  
			return m.find(); 
			*/
			String[] tmp = condition.split("[ ]");
			String[] tmp1 = src.split("[ ]");

			for (int i = 0; i + tmp.length <= tmp1.length; ++i) {
				String str = "";
				for (int j = 0; j < tmp.length; j++)
					str += tmp1[i + j] + " ";
				if (str.matches(condition))
					return true;
			}
		}
		return false;
	}

	public boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		return pattern.matcher(str).matches();
	}

	public boolean isPinYin(String str) {
		Pattern pattern = Pattern.compile("[ a-zA-Z]*");
		return pattern.matcher(str).matches();
	}

	public boolean containCn(String str) {
		Pattern pattern = Pattern.compile("[\\u4e00-\\u9fa5]");
		return pattern.matcher(str).find();
	}

}
