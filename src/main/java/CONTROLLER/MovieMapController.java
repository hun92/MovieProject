package CONTROLLER;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//http://localhost:8090/greaitProject/map/movieMap.mo

@WebServlet("/map/*")
public class MovieMapController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, 
					     HttpServletResponse response) 
					     throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, 
						  HttpServletResponse response) 
						  throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, 
							HttpServletResponse response) 
							throws ServletException, IOException {

			//한글처리
			request.setCharacterEncoding("UTF-8");
			
			//웹브라우저로 응답할 데이터 종류 설정
			response.setContentType("text/html; charset=utf-8");
			
			//서블릿으로 요청한 주소를 request에서 얻기
			String action = request.getPathInfo();
			System.out.println("요청한 주소 : " + action);
			
			//조건에 따라서  포워딩 또는 보여줄 VIEW주소 경로를 저장할 변수 
			String nextPage = null;
			// 요청한 중앙화면  뷰 주소를 저장할 변수 
			String center = null;
			
			//극장 찾기 버튼을 눌렀을때
			//한성준 
			if (action.equals("/movieMap.mo")) {
				
				request.setAttribute("center","/TheaterMap/KakaoMap.jsp");
				
				nextPage = "/index.jsp";
			
				
			//	심심해서 만든 미니 지뢰찾기
			//	이용우
			}else if(action.equals("/minigame.mo")) {
				
				
				request.setAttribute("center","/Main/minigame.jsp");
				
				nextPage = "/index.jsp";
				
				
			//	심심해서 만든게임 2	
			}else if(action.equals("/minigame2.mo")) {
						
						
					request.setAttribute("center","/Main/minigame2.jsp");
						
					nextPage = "/index.jsp";
						
			}else if(action.equals("/minigame3.mo")) {
				
				
				request.setAttribute("center","/Main/minigame3.jsp");
					
				nextPage = "/index.jsp";
				
			}else if(action.equals("/minigame4.mo")) {
				
				
				request.setAttribute("center","/Main/minigame4.jsp");
					
				nextPage = "/index.jsp";
				
			}
			
			
			
			
			//포워딩 (디스패처 방식)
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		
			dispatch.forward(request, response);
	
	}
	
}
