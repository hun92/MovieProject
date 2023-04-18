package CONTROLLER;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.openqa.selenium.json.Json;

import DAO.CommentDAO;
import VO.CommentVO;

@WebServlet("/comment/*")
public class CommentController extends HttpServlet {

	CommentDAO commentDAO;
	@Override
	public void init() throws ServletException {
		commentDAO = new CommentDAO();
	}
	
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
		
		//클라이언트의 웹브라우저로 응답할 데이터 종류 설정 및 문자처리방식 UTF-8설정 
		response.setContentType("text/html; charset=utf-8");
		
		//1.한글처리 
		request.setCharacterEncoding("UTF-8");
		//1.1 클라이언트가 요청한 2단계요청주소 request객체에서 얻기
		String action = request.getPathInfo();
		System.out.println("2단계 요청 주소 : " + action);
		
		String nextPage = null;
		
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		
		// 04/06 허상호 : 댓글 작성 버튼 클릭시 
		if(action.equals("/addComment.bo")) {
			String nickname = request.getParameter("nickname"); //로그인 했을 시 회원의 닉네임 
			String comment_nick = request.getParameter("comment_nick"); // 비로그인시 댓글 작성 닉네임
			String comment_pw = request.getParameter("comment_pw");
			String comment_content = request.getParameter("comment_content").trim();
			String c_idx = request.getParameter("c_idx");
			String comment_uniqueid = request.getParameter("comment_uniqueid");
			commentDAO.addComment(nickname,comment_nick,comment_pw,comment_content,c_idx,comment_uniqueid);
			return;
		// 04/09 허상호 : 댓글 수정 요청시 비밀번호 확인
		}else if(action.equals("/pwCheck.bo")) {
			String modPw = request.getParameter("modPw");
			String commentIdx = request.getParameter("commentIdx");
			int result = commentDAO.pwCheck(modPw,commentIdx);
			if(result == 1) {
				out.write("ok");
				return;
			}else {
				out.write("no");
				return;
			}
		// 04/09 허상호 : 댓글 수정 요청시 
		}else if(action.equals("/modContentPro.bo")) {
			String modRsContent = request.getParameter("modRsContent");
			String modCommentIdx = request.getParameter("modCommentIdx");
			int modRs = commentDAO.modContentPro(modRsContent, modCommentIdx);
			if(modRs == 1) {
				out.write("ok");
				return;
			}else {
				out.write("no");
				return;
			}
		// 04/09 허상호 : 댓글 삭제 요청시
		}else if(action.equals("/delCommentPro.bo")) {
			String delPw = request.getParameter("delPw");
			String commentIdx = request.getParameter("commentIdx");
			int delRs = commentDAO.delContentPro(delPw, commentIdx);
			if(delRs == 1) {
				out.write("ok");
				return;
			}else {
				out.write("no");
				return;
			}
		// 04/09 허상호 : 관리자 계정으로 댓글 삭제 요청시
		}else if(action.equals("/adminDelPro.bo")) {
			String commentIdx = request.getParameter("commentIdx");
			String superIdx = request.getParameter("c_idx");
			int adminRs = commentDAO.adminContentDel(commentIdx);
			if(adminRs != 1) {//삭제 실패시
				out.print("<script>window.alert('에러가 발생하였습니다.');");
				out.print("location.reload();</script>");
				return;
			}else {//삭제 성공시 
				out.print("<script>window.alert('글삭제 성공!');</script>");
				nextPage = "/com/read.bo?c_idx="+superIdx+"&nowPage=0&nowBlock=0";
			}
		}
		
		//포워딩 (디스패처 방식)
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//doHandle()메소드 끝 
	
	
}//클래스 끝