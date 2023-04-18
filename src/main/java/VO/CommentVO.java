package VO;

import java.sql.Date;

public class CommentVO {
	
	private int comment_idx, c_idx;
	private String comment_pw, m_nickname, comment_nick, comment_uniqueid, comment_content;
	private Date reg_date;
	
	
	public CommentVO() {
	}
	
	public CommentVO(int comment_idx, int c_idx, String comment_pw, String m_nickname, String comment_nick,
			String comment_uniqueid, String comment_content) {
		this.comment_idx = comment_idx;
		this.c_idx = c_idx;
		this.comment_pw = comment_pw;
		this.m_nickname = m_nickname;
		this.comment_nick = comment_nick;
		this.comment_uniqueid = comment_uniqueid;
		this.comment_content = comment_content;
	}
	public CommentVO(int comment_idx, int c_idx, String comment_pw, String m_nickname, String comment_nick,
			String comment_uniqueid, String comment_content, Date reg_date) {
		this.comment_idx = comment_idx;
		this.c_idx = c_idx;
		this.comment_pw = comment_pw;
		this.m_nickname = m_nickname;
		this.comment_nick = comment_nick;
		this.comment_uniqueid = comment_uniqueid;
		this.comment_content = comment_content;
		this.reg_date = reg_date;
	}
	public int getComment_idx() {
		return comment_idx;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public String getComment_pw() {
		return comment_pw;
	}
	public void setComment_pw(String comment_pw) {
		this.comment_pw = comment_pw;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getComment_nick() {
		return comment_nick;
	}
	public void setComment_nick(String comment_nick) {
		this.comment_nick = comment_nick;
	}
	public String getComment_uniqueid() {
		return comment_uniqueid;
	}
	public void setComment_uniqueid(String comment_uniqueid) {
		this.comment_uniqueid = comment_uniqueid;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
}
