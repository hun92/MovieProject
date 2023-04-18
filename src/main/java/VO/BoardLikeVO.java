package VO;

public class BoardLikeVO {
	private int c_idx;
	private String m_uniqueid;
	private String m_nickname;
	private String likecheck;
	
	public BoardLikeVO(int c_idx, String m_uniqueid, String m_nickname, String likecheck) {
		super();
		this.c_idx = c_idx;
		this.m_uniqueid = m_uniqueid;
		this.m_nickname = m_nickname;
		this.likecheck = likecheck;
	}
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getLikecheck() {
		return likecheck;
	}
	public void setLikecheck(String likecheck) {
		this.likecheck = likecheck;
	}

	public String getM_uniqueid() {
		return m_uniqueid;
	}

	public void setM_uniqueid(String m_uniqueid) {
		this.m_uniqueid = m_uniqueid;
	}
	
	
}
