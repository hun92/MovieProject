package VO;



public class ChatVO {
    int    chatID; // 쉬퀀스 사용, 프라이머리키 
	String m_nickname; //채팅을 작성한 사용자의 닉네임을 저장합니다.
	String chatContent; //채팅 내용을 저장합니다.
	String chatTime; //채팅이 작성된 시간을 저장합니다.
	
	public ChatVO() {
		
	}

	public ChatVO(int chatID, String m_nickname, String chatContent, String chatTime) {
		this.chatID = chatID;
		this.m_nickname = m_nickname;
		this.chatContent = chatContent;
		this.chatTime = chatTime;
	}

	public int getChatID() {
		return chatID;
	}

	public void setChatID(int chatID) {
		this.chatID = chatID;
	}

	public String getM_nickname() {
		return m_nickname;
	}

	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}

	public String getChatContent() {
		return chatContent;
	}

	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}

	public String getChatTime() {
		return chatTime;
	}

	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	
	
	

	
}
