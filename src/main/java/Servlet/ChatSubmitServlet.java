package Servlet;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ChatDAO;



@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    
	
	protected void doPost(HttpServletRequest request, 
							HttpServletResponse response) 
									throws ServletException, IOException {
	
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//웹브라우저로 응답할 데이터 종류 설정
		response.setContentType("text/html; charset=utf-8");
	
		String m_nickname = URLDecoder.decode(request.getParameter("m_nickname"),"UTF-8");
		
		String chatContent = URLDecoder.decode(request.getParameter("chatContent"),"UTF-8");
		
		
		if(m_nickname == null || m_nickname.isEmpty() || chatContent == null || chatContent.isEmpty()) {
		    response.getWriter().write("0");
		} else {
		    response.getWriter().write(new ChatDAO().submit(m_nickname,chatContent) + "");
		}
		
	}

}
