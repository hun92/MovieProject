package VO;

import java.sql.Date;

public class CommunityVO {
	private int c_idx;
	private String c_title;
	private String c_nickname;
	private String c_uniqueid;
	private String c_password;
	private String c_content;
	private Date c_date;
	private int c_views;
	private int c_like;
	private int c_group;
	private int c_level;

	public CommunityVO(int c_idx, String c_title, String c_nickname, String c_uniqueid, String c_password,
			String c_content, Date c_date, int c_views, int c_like, int c_group, int c_level) {
		super();
		this.c_idx = c_idx;
		this.c_title = c_title;
		this.c_nickname = c_nickname;
		this.c_uniqueid = c_uniqueid;
		this.c_password = c_password;
		this.c_content = c_content;
		this.c_date = c_date;
		this.c_views = c_views;
		this.c_like = c_like;
		this.c_group = c_group;
		this.c_level = c_level;
	}

	public CommunityVO() {}

	public int getC_idx() {
		return c_idx;
	}

	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}

	public String getC_title() {
		return c_title;
	}

	public void setC_title(String c_title) {
		this.c_title = c_title;
	}

	public String getC_nickname() {
		return c_nickname;
	}

	public void setC_nickname(String c_nickname) {
		this.c_nickname = c_nickname;
	}

	public String getC_password() {
		return c_password;
	}

	public void setC_password(String c_password) {
		this.c_password = c_password;
	}

	public String getC_content() {
		return c_content;
	}

	public void setC_content(String c_content) {
		this.c_content = c_content;
	}

	public Date getC_date() {
		return c_date;
	}

	public void setC_date(Date c_date) {
		this.c_date = c_date;
	}

	public int getC_views() {
		return c_views;
	}

	public void setC_views(int c_views) {
		this.c_views = c_views;
	}

	public int getC_like() {
		return c_like;
	}

	public void setC_like(int c_like) {
		this.c_like = c_like;
	}

	public int getC_group() {
		return c_group;
	}

	public void setC_group(int c_group) {
		this.c_group = c_group;
	}

	public int getC_level() {
		return c_level;
	}

	public void setC_level(int c_level) {
		this.c_level = c_level;
	}

	public String getC_uniqueid() {
		return c_uniqueid;
	}

	public void setC_uniqueid(String c_uniqueid) {
		this.c_uniqueid = c_uniqueid;
	}
	
	
	
}
