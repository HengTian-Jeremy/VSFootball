package com.engagemobile.vsfootball.view;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ListView;
import android.widget.SectionIndexer;
import android.widget.TextView;

public class SideBar extends View {
	private char[] alpha;
	private SectionIndexer sectionIndexter = null;
	private ListView list;
	private TextView mDialogText;
	private static SideBar instance;

	public void setmDialogText(TextView mDialogText) {
		this.mDialogText = mDialogText;
	}

	private int m_nItemHeight = 30;

	public SideBar(Context context) {
		super(context);
		init();
		setInstance(this);
	}

	public SideBar(Context context, AttributeSet attrs) {
		super(context, attrs);
		init();
		setInstance(this);
	}

	private void init() {
		alpha = new char[] { '#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
				'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
				'V', 'W', 'X', 'Y', 'Z' };
	}

	public SideBar(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		init();
		setInstance(this);
	}

	public void setListView(ListView _list) {
		list = _list;
		sectionIndexter = (SectionIndexer) _list.getAdapter();
	}

	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		// TODO Auto-generated method stub
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
		int height = getMeasuredHeight();
		m_nItemHeight = height / 27;
		int width = getMeasuredWidth();
	}

	public boolean onTouchEvent(MotionEvent event) {
		super.onTouchEvent(event);
		//		int i = (int) event.getY();
		//		int idx = i / m_nItemHeight;
		//		if (idx >= alpha.length) {
		//			idx = alpha.length - 1;
		//		} else if (idx < 0) {
		//			idx = 0;
		//		}
		//		if (event.getAction() == MotionEvent.ACTION_DOWN
		//				|| event.getAction() == MotionEvent.ACTION_MOVE) {
		//			mDialogText.setVisibility(View.VISIBLE);
		//			mDialogText.setText("" + alpha[idx]);
		//			if (sectionIndexter == null) {
		//				sectionIndexter = (SectionIndexer) list.getAdapter();
		//			}
		//			int position = sectionIndexter.getPositionForSection(alpha[idx]);
		//			if (position == -1) {
		//				return true;
		//			}
		//			list.setSelection(position);
		//		} else {
		//			mDialogText.setVisibility(View.INVISIBLE);
		//		}
		return true;
	}

	protected void onDraw(Canvas canvas) {
		Paint paint = new Paint();
		paint.setColor(Color.parseColor("#2e96df"));
		paint.setTextSize(m_nItemHeight / 5 * 4);
		paint.setTextAlign(Paint.Align.CENTER);
		float widthCenter = getMeasuredWidth() / 2;
		for (int i = 0; i < alpha.length; i++) {
			canvas.drawText(String.valueOf(alpha[i]), widthCenter,
					m_nItemHeight + (i * m_nItemHeight), paint);
		}
		super.onDraw(canvas);
	}

	public static SideBar getInstance() {
		return instance;
	}

	public static void setInstance(SideBar instance) {
		SideBar.instance = instance;
	}
}
