package Servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ChatDAO;
import VO.ChatVO;

 
@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//웹브라우저로 응답할 데이터 종류 설정
		response.setContentType("text/html; charset=UTF-8");
		
		// listType 파라미터 값 추출
		String listType = request.getParameter("listType");
		
		// listType이 null이거나 빈 문자열인 경우, 빈 문자열을 반환하여 웹브라우저로 전송
		if(listType == null || listType.equals("")) {
			
			response.getWriter().write("");
			
		// listType이 "today"인 경우, getToday() 메소드를 실행하여 오늘 날짜의 채팅 목록을 JSON 형태로 반환하여 웹브라우저로 전송
		}else if(listType.equals("today")) { 
			
			response.getWriter().write(getToday());//AJAX로 조회 요청한 chat.jsp로
			
		}	
		
		// listType이 숫자인 경우, getID() 메소드를 실행하여 해당 ID의 채팅 목록을 JSON 형태로 반환하여 웹브라우저로 전송
		else {
			try {
				Integer.parseInt(listType);
				response.getWriter().write(getID(listType));
			} catch (Exception e) {
				response.getWriter().write("");
			}
		}
	}
	
	// 오늘 날짜의 채팅 목록을 JSON 형태로 반환하는 getToday() 메소드
	public String getToday() {
		
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		ChatDAO chatDAO = new ChatDAO();
		
		// ChatDAO의 getChatList() 메소드를 호출하여 오늘 날짜의 채팅 목록을 가져옴
		ArrayList<ChatVO> chatList = chatDAO.getChatList(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

		// 가져온 채팅 목록을 JSON 형태로 변환하여 result에 추가
		for (int i = 0; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getM_nickname() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
			if(i != chatList.size() - 1) result.append(",");
			
		}
		// JSON 형태의 결과를 반환
		result.append("], \"last\":\"" + chatList.get(chatList.size() - 1).getChatID() + "\"}");

		return result.toString();
	}
	
	
	public String getID(String chatID) {
		
		// 결과를 저장할 StringBuffer 객체 생성
		StringBuffer result = new StringBuffer("");
		
		// 초기 JSON 문자열 추가
		result.append("{\"result\":[");
		
		// ChatDAO 인스턴스 생성
		ChatDAO chatDAO = new ChatDAO();
		
		// chatID에 해당하는 채팅 데이터 10개를 가져와 chatList에 저장
		ArrayList<ChatVO> chatList = chatDAO.getChatListByRecent(chatID);
		
		// chatList에 있는 각 채팅 데이터의 정보를 result buffer에 추가
		for (int i = 0; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getM_nickname() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
			
			// 만약 현재 채팅 데이터가 chatList의 마지막 데이터가 아니면 콤마 추가
			if(i != chatList.size() - 1) result.append(",");
			
		}
		
		// 마지막 JSON 문자열 추가, chatList에서 마지막 채팅 데이터의 nickname 정보가 들어감
		result.append("], \"last\":\"" + chatList.get(chatList.size() - 1).getM_nickname() + "\"}");
		
		// 결과 buffer를 String으로 변환하여 반환
		return result.toString();
	
	}
	
}
