package CONTROLLER;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialException;

import org.apache.catalina.tribes.UniqueId;

import DAO.CommunityDAO;
import DAO.MemberDAO;
import VO.CommunityVO;
import VO.MemberVO;
import smtp.SendEmail;

@WebServlet("/member1/*") 
public class MemberController extends HttpServlet {
	//멤버 서비스 추가
	
		MemberDAO memberdao;
		CommunityDAO comdao;
		
		@Override
		public void init() throws ServletException {
			memberdao = new MemberDAO();
			comdao = new CommunityDAO();
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
		
			//한글처리
			request.setCharacterEncoding("UTF-8");
		
			//웹브라우저로 응답할 데이터 종류 설정
			response.setContentType("text/html; charset=utf-8");
		
			//웹브라우저와 연결된 출력 스트림 통로 만들기
			PrintWriter out = response.getWriter();
		
			//서블릿으로 요청한 주소를 request에서 얻기
			String action = request.getPathInfo();
			System.out.println("요청한 주소 : " + action);
		
			//조건에 따라서  포워딩 또는 보여줄 VIEW주소 경로를 저장할 변수 
			String nextPage = null;
			// 요청한 중앙화면  뷰 주소를 저장할 변수 
			String center = null;
			
			HttpSession session = request.getSession();
			
			String uniqueID = (String)session.getAttribute("m_uniqueID");
			
			//메인화면 요청주소
			if(action.equals("/main.me")) {
				
				
				nextPage = "/Crawling/maincenter.me";
			
			//회원 가입 눌렀을때 보여주는페이지
			}else if (action.equals("/join1.me")) {
				
				request.setAttribute("center", "/Member/join1.jsp");
				nextPage = "/index.jsp";
				
				
			//회원가입 약관동의 했을경우 다음패이지로 확인	
			}else if (action.equals("/join2.me")) {
				
				request.setAttribute("center", "/Member/join2.jsp");
				nextPage = "/index.jsp";
				
			
			//회원가입 실행 
			}else if(action.equals("/joinPro.me")) {
				//요청한 값 얻기
				String m_nickname = request.getParameter("m_nickname");
				String m_id = request.getParameter("m_id");
				String m_pw = request.getParameter("m_pw");
				String m_name = request.getParameter("m_name");
				String m_email = request.getParameter("m_email");
				int new_uniqueID = memberdao.getUniqueid();
				String m_uniqueID = String.valueOf(new_uniqueID);
				System.out.println("joinPro.me 고유 아이디 : " + new_uniqueID);
				
				MemberVO vo = new MemberVO(
											m_uniqueID,
											m_nickname,
											m_id,
											m_pw,
											m_name,
											m_email,
											0,
											1,
											"egg.png"
											);
				
				
				memberdao.insertMember(vo);

				request.setAttribute("center", "/Member/join3.jsp");
				nextPage = "/index.jsp";

				
			//회원가입 닉네임 얻기
			}else if (action.equals("/joinNicknameCheck.me")) {
				//입력한 닉네임 얻기
				String m_nickname = request.getParameter("m_nickname");
				MemberVO memvo = new MemberVO();
				memvo.setM_nickname(m_nickname);
				
				//0329 정태영 : 
				//modMemberForm1에서 ajax를 통해 아이디를 변경하는 경우
				//purpose에 change를 대입해서 수정이 목적인 경우 중복체크와 
				//수정까지 동시에 이루어지도록 함
				String purpose = request.getParameter("purpose");
				
											//닉네임의 중복을 체크해주는 메서드
				boolean result = memberdao.overlappedNickname(m_nickname);
				
				
				if(result == true) {
					out.write("not_usable");
					return;
				}else {
					if(purpose != null) {
						int updateResult = memberdao.updateMember(memvo, uniqueID);
					}
					out.write("usable");
					return;
				}
				

			//회원가입 아이디 얻기
			}else if(action.equals("/joinIdCheck.me")) {
			//입력한 아이디 얻기
				String m_id = request.getParameter("m_id");
				
				MemberVO memvo = new MemberVO();
				memvo.setM_id(m_id);
				
				//0329 정태영 : 
				//modMemberForm1에서 ajax를 통해 아이디를 변경하는 경우
				//purpose에 change를 대입해서 수정이 목적인 경우 중복체크와 
				//수정까지 동시에 이루어지도록 함
				String purpose = request.getParameter("purpose");
				
				
				
				//입력한 아이디가 DB에 저장되어 있는지 중복 체크 작업 
				//true -> 중복 , false -> 중복아님  둘중 하나를 반환 받음
				boolean result = memberdao.overlappedId(m_id);
				
				//아이디 중복결과를 다시 한번 확인 하여 조건값을 
				//join.jsp파일과 연결된 join.js파일에 작성해 놓은
				//success:function의 data매개변수로 웹브라우저를 거쳐 보냅니다!
				if(result == true) {
					out.write("not_usable");
					return;
				}else {
					if(purpose != null) {
						int updateResult = memberdao.updateMember(memvo, uniqueID);
					}
					out.write("usable");
					return;
				}
			
				
			//회원가입 이메일 얻기
			}else if(action.equals("/joinEmailCheck.me")) {
			//입력한 이메일 얻기
				String m_email = request.getParameter("m_email");
				MemberVO memvo = new MemberVO();
				memvo.setM_email(m_email);
				
				//0329 정태영 : 
				//modMemberForm1에서 ajax를 통해 아이디를 변경하는 경우
				//purpose에 change를 대입해서 수정이 목적인 경우 중복체크와 
				//수정까지 동시에 이루어지도록 함
				String purpose = request.getParameter("purpose");
				
				
				//입력한 이메일이 DB에 저장되어 있는지 중복 체크 작업 
				//true -> 중복 , false -> 중복아님  둘중 하나를 반환 받음
				boolean result = memberdao.overlappedEmail(m_email);
				
				//이메일 중복결과를 다시 한번 확인 하여 조건값을 
				//join.jsp파일과 연결된 join.js파일에 작성해 놓은
				//success:function의 data매개변수로 웹브라우저를 거쳐 보냅니다!
				if(result == true) {
					out.write("not_usable");
					return;
				}else {
					if(purpose != null) {
						int updateResult = memberdao.updateMember(memvo, uniqueID);
					}
					out.write("usable");
					return;
				} 
			}	
			else if(action.equals("/joinPwCheck.me")) {
				//입력한 이메일 얻기
					String m_pw = request.getParameter("m_pw");
					m_pw = memberdao.hashpw(m_pw);
					MemberVO memvo = new MemberVO();
					memvo.setM_pw(m_pw);
					
					//0329 정태영 : 
					//modMemberForm1에서 ajax를 통해 아이디를 변경하는 경우
					//purpose에 change를 대입해서 수정이 목적인 경우 중복체크와 
					//수정까지 동시에 이루어지도록 함
					String purpose = request.getParameter("purpose");
					
					int updateResult = memberdao.updateMember(memvo, uniqueID);
					
					if(updateResult == 0) {
						out.write("not_usable");
						return;
					}else {
						out.write("usable");
						return;
					}
			}
			
			//로그인 수행
			else if(action.equals("/login.me")) {//로그인 창으로 이동
				
				request.setAttribute("center", "/Member/login.jsp");
				
				nextPage = "/index.jsp";			
				
			
			//로그인 유효성검
			}else if(action.equals("/loginPro.me")) {//로그인 수행
				String m_id = request.getParameter("m_id");
				String m_pw = request.getParameter("m_pw");
				String nickname = null;
				MemberVO memberVO = new MemberVO();
				
				int check = memberdao.loginCheck(m_id, m_pw);

				if(check == 0) {//아이디는 맞고 비번 틀림
					out.println("<script>");
					out.println(" window.alert('비밀번호 틀림');");
					out.println(" history.go(-1);");
					out.println("</script>");
					return;
				}else if(check == -1) {//아이디 틀림 , 비밀번호 맞음 	
					out.println("<script>");
					out.println(" window.alert('아이디 틀림');");
					out.println(" history.back();");
					out.println("</script>");
					return;				
				}else if(check == 1){
					nickname = memberdao.logName(m_id);
					memberVO = memberdao.getMemVO(nickname);
				}
				
				//session메모리에 입력한 아이디 바인딩(저장)
				session.setAttribute("m_nickname", nickname);
				
				//0325 정태영 : session에 고유 id 저장
				session.setAttribute("m_uniqueID", memberVO.getM_uniqueid());
				
				//메인화면 VIEW 주소
				nextPage = "/Crawling/maincenter.me";

		
			//로그아웃 수행	
			}else if(action.equals("/logoutPro.me")) {//로그아웃 수행
					//기존에 생성했던 session메모리 얻기
				session.invalidate();
		
				nextPage = "/Crawling/maincenter.me";
		
				
					
			//로그아웃 실행
			}else if (action.equals("/logout.me")) {//로그아웃
					
					
				session.invalidate();
							
				nextPage = "/Crawling/maincenter.me";
				
				
			// 아이디 찾기 
			}else if(action.equals("/findID.me")) {//아이디 찾기
				//request.setAttribute("center","findId.jsp");
				nextPage = "/Member/findID.jsp";
			}	
			//login.jsp에서 아이디 찾기 버튼을 눌렀을 경우
			//사용자로부터 이름과 이메일을 전달받고 findId()메서드를 이용해
			//두 값에 해당하는 사용자의 아이디를 반환받는다.
			//	
			else if(action.equals("/findIdResult.me")) {//아이디 찾기
					
				String m_name = request.getParameter("m_name");
				String m_email = request.getParameter("m_email");
				String m_id = memberdao.findId(m_name,m_email);
				if( m_id == null) {//
					out.println("<script>");
					out.println(" window.alert('회원 정보가 틀립니다 다시 입력해주세요');");
					out.println(" history.go(-1);");
					out.println("</script>");
					return;
				}else if (m_id != null){
					request.setAttribute("m_id", m_id);
				}
				nextPage = "/Member/findID2.jsp";
			}
			//login.jsp에서 비밀번호를 변경하기 위해 인증 페이지로 연결한다.
			else if (action.equals("/changePW.me")) {//비밀번호 찾기수행
					
					//아이디, 이름, 이메일을 입력받는 페이지
					nextPage = "/Member/changePW_1.jsp";
					
			}		
			//change_1.jsp에서 회원 인증 버튼을 눌렀을 때 request로 회원을 이름, 아이디, 이메일을
			//각각 m_name, m_id, m_email로 전달받고 findPW() 메서드를 이용해 사용자가 입력한 3개의 값과
			//동일한 유저의 비밀번호 문자열을 반환받고 해당하는 유저가 없을 경우(비밀번호가 비어 있을 경우)
			//ajax의 data에 false를 전달하고, 성공하면 true를 전달한다.		
			else if(action.equals("/changePW2.me")) {
					
				String m_name = request.getParameter("m_name");
				String m_id= request.getParameter("m_id");
				String m_email = request.getParameter("m_email");
				
				String m_pw = memberdao.findPW(m_name,m_id,m_email);
				
				System.out.println(m_pw);
				
				if(m_pw == null) {
					out.write("false");
				}else if (m_pw != null){
					out.write("true");
				}
				return;
			}	
			
			//change_1.jsp에서 입력받은 이메일, 이름, 아이디, 비밀번호, 비밀번호 확인을 통해
			//회원의 비밀번호를 변경하는 기능
			else if(action.equals("/changePW3.me")) {
				String m_name = request.getParameter("m_name");
				String m_id = request.getParameter("m_id");
				String m_email = request.getParameter("m_email");
				String m_pw = request.getParameter("m_pw");
				
				int result = memberdao.changePW(m_name, m_id, m_email, m_pw);
				
				request.setAttribute("result", result);
				
				nextPage = "/Member/changePWResult.jsp";
			}
			
			//카카오 로그인창에서 로그인 버튼을 눌렀을 때
			else if(action.equals("/kakaoLoginPro.me")) {
				String kakao_name = request.getParameter("name");
				String kakao_uniqueID = request.getParameter("uniqueID");
				String kakao_email = request.getParameter("email");
				int result = 0;
				
				MemberVO kakao_vo = memberdao.getMemVOByUniqueID(kakao_uniqueID);
				
				if(kakao_vo == null) {
					System.out.println("kakaoLoginPro, 저장된 정보가 없으니 회원가입을 실행하겠습니다.");
					result = memberdao.insertKakaoMember(kakao_name, kakao_uniqueID, kakao_email);
					if(result == 1) {
						session.setAttribute("m_uniqueID", kakao_uniqueID);
						session.setAttribute("m_nickname", "(kakao)"+kakao_name);
						out.write("1");
					}
				} else {
					session.setAttribute("m_uniqueID", kakao_uniqueID);
					session.setAttribute("m_nickname", "(kakao)"+kakao_name);
					out.write("1");
				}
				return;
			}
			
			else if(action.equals("/naverLoginAuth.me")) {
				String code = request.getParameter("code");
				String state = request.getParameter("state");
				String clientId = "Kf9C_RzsFYJraczQjC3Q";//애플리케이션 클라이언트 아이디값";
			    String client_secret = "zUvJzqCB3f";
			    String redirectURI = URLEncoder.encode("http://localhost:8090/greaitProject/naver/login", "UTF-8");
				String url = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=Kf9C_RzsFYJraczQjC3Q&client_secret=zUvJzqCB3f&code="+code+"&state="+state;
				System.out.println(url);
				
				String jo = null;
				try (java.util.Scanner s = new java.util.Scanner(new java.net.URL(url).openStream(), "UTF-8").useDelimiter("\\A")) {
					jo = s.next();
				} catch (java.io.IOException e) {
				    e.printStackTrace();
				}
				System.out.println(jo);
				
				request.setAttribute("token", jo);
				request.setAttribute("center", "/Member/naverLogin.jsp");
				
				nextPage = "/index.jsp";
			}
			
			else if(action.equals("/naverLoginPro.me")) {
				String token = request.getParameter("token");
		        String header = "Bearer " + token; // Bearer 다음에 공백 추가


		        String apiURL = "https://openapi.naver.com/v1/nid/me";


		        Map<String, String> requestHeaders = new HashMap<>();
		        requestHeaders.put("Authorization", header);
		        String responseBody = get(apiURL,requestHeaders);


		        System.out.println(responseBody);
				
		        out.write(responseBody);
				
				return;
			}
			
			else if(action.equals("/naverLoginProReal.me")) {
				String naver_uniqueID = request.getParameter("uniqueID");
				String naver_name = request.getParameter("name");
				String naver_email = request.getParameter("email");
				
				int result = 0;
				
				MemberVO naver_vo = memberdao.getMemVOByUniqueID(naver_uniqueID);
				
				if(naver_vo == null) {
					System.out.println("naverLoginProReal, 저장된 정보가 없으니 회원가입을 실행하겠습니다.");
					result = memberdao.insertNaverMember(naver_name, naver_uniqueID, naver_email);
					if(result == 1) {
						session.setAttribute("m_uniqueID", naver_uniqueID);
						session.setAttribute("m_nickname", "(naver)"+naver_name);
						out.print("1");
					}
				} else {
					session.setAttribute("m_uniqueID", naver_uniqueID);
					session.setAttribute("m_nickname", "(naver)"+naver_name);
					out.print("1");
				}
				
//				//메인화면 view 주소
//				nextPage ="/Crawling/maincenter.me";
				return;
			}
			
			else if(action.equals("/googleLogin.me")) {
				String token = request.getParameter("token");
				String url = "https://oauth2.googleapis.com/tokeninfo?id_token=" + token;
				
				URL obj = new URL(url);
		        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		        con.setRequestMethod("GET");

		        int responseCode = con.getResponseCode();
		        System.out.println("Response Code : " + responseCode);

		        BufferedReader in = new BufferedReader(
		                new InputStreamReader(con.getInputStream()));
		        String inputLine;
		        StringBuffer response2 = new StringBuffer();

		        while ((inputLine = in.readLine()) != null) {
		            response2.append(inputLine);
		        }
		        in.close();

		        // 사용자 정보 파싱
		        String jsonResponse = response2.toString();
		        Map<String, String> userData = new HashMap<String, String>();
		        String[] keyValuePairs = jsonResponse.substring(1, jsonResponse.length() - 1).split(",");
		        for (String pair : keyValuePairs) {
		            String[] entry = pair.split(":");
		            userData.put(entry[0].trim().replaceAll("\"", ""), entry[1].trim().replaceAll("\"", ""));
		        }
		        
		        String googleUniqueID = userData.get("sub");
		        String googleName = userData.get("name");
		        String googleEmail = userData.get("email");
		        
		        // 사용자 정보 출력
		        System.out.println("User ID: " + googleUniqueID);
		        System.out.println("Name: " + googleName);
		        System.out.println("Email: " + googleEmail);
		        
		        int result = 0;
				
				MemberVO google_vo = memberdao.getMemVOByUniqueID(googleUniqueID);
				
				if(google_vo == null) {
					System.out.println("googleLogin, 저장된 정보가 없으니 회원가입을 실행하겠습니다.");
					result = memberdao.insertGoogleMember(googleName, googleUniqueID, googleEmail);
					if(result == 1) {
						session.setAttribute("m_uniqueID", googleUniqueID);
						session.setAttribute("m_nickname", "(google)"+googleName);
						out.print("1");
					}
				}
				else {
					session.setAttribute("m_uniqueID", googleUniqueID);
					session.setAttribute("m_nickname", "(google)"+googleName);
					out.print("1");
				}
				return;
			}
			
			//마이페이지에 들어가기 요청을 받으면
			//request에서 해당 유저의 uniqueID를 전달받아 변수에 저장하고
			//uniqueID를 이용해 유저의 정보를 객체로 반환받아 vo 변수에 저장한다.
			//유저가 작성한 게시글을 확인하기 위해 유저의 uniqueID를 이용해 getAllComListByUniqueID() 메서드를 호출하여
			//작성한 모든 게시글을 정보를 list에 저장하고 반환받은 후 vo와 list를 request로 전달한 후
			//myPage.jsp를 재요청한다.
			else if(action.equals("/mypage.me")) { 
				
				//고유아이디를 통해 회원정보를 조회하도록 요청
				String userUniqueID = request.getParameter("userUniqueID");
				
				System.out.println("mypage, uniqueID: " + userUniqueID);
				
				MemberVO vo = memberdao.getMemVOByUniqueID(userUniqueID);
				
				List<CommunityVO> list = comdao.getAllComListByUniqueID(userUniqueID);

				//View중앙화면에 보여주기 위해 request에  vo를 바인딩
				request.setAttribute("vo", vo);
				request.setAttribute("comlist", list);
				request.setAttribute("center", "/Member/myPage.jsp");
				
	
				nextPage = "/index.jsp";
			}
				
			//회원 정보수정을 위한 회원 확인 비밀번호인증
			//myPage.jsp에서 회원 수정 버튼을 눌렀을 경우 request로 purpose에 update를 바인딩하고
			//modMemberForm.jsp를 재요청한다.
			else if (action.equals("/mypageUpdate.me")) {
				
				request.setAttribute("center", "/Member/modMemberForm.jsp");
				request.setAttribute("purpose", "update");
				
				nextPage = "/index.jsp";
				
			}
			
			//회원 탈퇴를 위한 회원 확인 비밀번호인증
			//myPage.jsp에서 회원 탈퇴 버튼을 눌렀을 경우 request로 purpose에 withdrawal를 바인딩하고
			//modMemberForm.jsp를 재요청한다.
			else if (action.equals("/withdrawal.me")) {
				request.setAttribute("center", "/Member/modMemberForm.jsp");
				request.setAttribute("purpose", "withdrawal");
				nextPage = "/index.jsp";
			}
			
			//modMemberForm에서 회원 탈퇴 버튼을 눌렀을 때
			//입력한 비밀번호를 request로 전달받고 변수 m_pw에 저장한 후
			//session에 저장된 uniqueID를 이용해 유저의 memberVO객체를 전달받아
			//유저의 암호화된 비밀번호를 구한다.
			//checkpw() 메서드를 호출하여 유저가 입력한 비밀번호와 암호화된 비밀번호를 비교하여
			//입력값이 동일하면 withdrawalPro() 메서드를 호출하여 회원 탈퇴를 실행한 후
			//실행의 성공여부를 int result에 저장한다.
			//modMemberForm1.jsp을 재요청한다.
			else if (action.equals("/withdrawal1.me")) {
				String contextPath = request.getContextPath();
				String m_pw = request.getParameter("m_pw");
				MemberVO vo = memberdao.getMemVOByUniqueID(uniqueID);
				String loginPw = vo.getM_pw();
				int result = 0;
				
				//입력한 비밀번호와 DB에 저장된 비밀번호가 동일한지 체크!
				if(memberdao.checkpw(m_pw, loginPw)) {
					result = memberdao.withdrawalPro(uniqueID);
				}
				
				if(result == 1) {
					out.println("<script>");
					out.println(" window.alert('회원 탈퇴에 성공했습니다.');");
					session.invalidate();
					out.println(" location.href='"+contextPath+"/Crawling/maincenter.me' ");
					out.println("</script>");
				} else {
					out.println("<script>");
					out.println(" window.alert('회원 탈퇴에 실패했습니다.');");
					out.println(" history.go(-1);");
					out.println("</script>");
				}
				
				return;
			}
				
			//modMemberForm에서 회원 수정 버튼을 눌렀을 때
			//입력한 비밀번호를 request로 전달받고 변수 m_pw에 저장한 후
			//session에 저장된 uniqueID를 이용해 유저의 memberVO객체를 전달받아
			//유저의 암호화된 비밀번호를 구한다.
			//checkpw() 메서드를 호출하여 유저가 입력한 비밀번호와 암호화된 비밀번호를 비교하여
			//입력값이 동일하면 유저의 정보가 담긴 객체(vo)를 리퀘스트로 전달하고,
			//modMemberForm1.jsp을 재요청한다.
			else if (action.equals("/mypageUpdate1.me")) {
				String m_pw = request.getParameter("m_pw");
				
				MemberVO vo = memberdao.getMemVOByUniqueID(uniqueID);
				//DB에 저장되어 있는 값
				String loginPw = vo.getM_pw();
				
				if(memberdao.checkpw(m_pw, loginPw)) {
					request.setAttribute("vo", vo);	
					request.setAttribute("center", "/Member/modMemberForm1.jsp");
					nextPage = "/index.jsp";
					
				}else {
					out.println("<script>");
					out.println(" window.alert('비밀번호가 틀립니다 다시 입력해주세요');");
					out.println(" history.go(-1);");
					out.println("</script>");
					return;
				}
			}	
			//회원탈퇴를 위해 비밀번호를 입력하는 화면 요청! 
			else if(action.equals("/delete.me")) {
			
				nextPage = "/Member/Delete.jsp";
			}	
			
			//mypage.jsp에서 레벨업 버튼을 눌렀을 때 호출됨.
			//ajax로부터 전달받은 uniqueID를 이용하여 getMemVOByUniqueID() 메서드를 이용해
			//memberVO를 반환받고 반환받은 유저 객체의 경험치 / 10 하여 몫을 레벨로 설정하고
			//나머지를 경험치로 설정한다. 레벨이 10씩 증가할 때마다 유저의 이미지가 바뀌며
			//결과적으로 레벨을 반환한다.
			else if(action.equals("/levelUp.me")) {
				MemberVO membervo = memberdao.getMemVOByUniqueID(uniqueID);
				String gradeImage = null;
				int insert_level = 1 + membervo.getM_exp()/100;
				if(insert_level > 10) {
					gradeImage = "egg_fried.png";
					if(insert_level > 20) {
						gradeImage = "bronze-medal.png";
						if(insert_level > 30) {
							gradeImage = "silver-medal.png";
							if(insert_level > 40) {
								gradeImage = "gold-medal.png";
							}
						}
					}
				} else {
					gradeImage = "egg.png";
				}
				System.out.println("levelUp, 레벨 : " + insert_level + "이미지 명 : " + gradeImage);
				
				String level = memberdao.updateLevel(membervo.getM_exp(), uniqueID, gradeImage);
				
				out.print(level);
				return;
			}
			
			//로그인 후 sidebar.jsp에서 랭킹 보기를 눌렀을 때
			//모든 회원 정보(MemberVO)를 List로 저장하는 getAllMemberList() 메서드를 이용해
			//list에 저장하고, request에 바인딩 한 후 /Member/ranking.jsp를 재요청합니다.
			else if(action.equals("/ranking.me")) {
				System.out.println(true);
				
				List<MemberVO> list = memberdao.getAllMemberList();
				
				request.setAttribute("list", list);
				request.setAttribute("center", "/Member/ranking.jsp");
				nextPage = "/index.jsp";
			}
			
			//인증메일 보내기
			//join2.jsp에서 이메일 인증 버튼을 눌렀을 때
			//request로 전달된 사용자의 이름과 이메일을 각 변수 m_email, m_name에 저장해
			//sendEmail() 메서드를 이용해 이메일을 전송합니다.
			else if(action.equals("/sendEmailAuth.me")) {
				String m_email = request.getParameter("m_email");
				String m_name = request.getParameter("m_name");
				String authCode = memberdao.getAuthCode();
				String title = "Mood Movie입니다. 인증메일 확인 바랍니다.";
				
				SendEmail.sendEmail(m_email, m_name, title, authCode);
				
				authCode = memberdao.hashpw(authCode);
				
				session.setAttribute("authCode", authCode);
				
				out.write(authCode);
				return;
			}
			
			//이메일 인증
			//join2.jsp에서 이메일 인증 버튼을 눌렀을 때
			//세션에 저장된 인증번호(authCode)와 jsp에서 request로 전달된 인증번호 확인(auth)의 값을
			//checkPW() 메서드를 이용하여 입력한 값이 세션에 저장된 값과 동일하면 true를 반환함.
			else if(action.equals("/emailAuth.me")) {
				//auth: jsp에서 받아온, 사용자가 작성한 인증번호
				//authCode: session에 저장된 사용자의 이메일로 보내진 인증번호
				String HashedCode = (String)session.getAttribute("authCode");
				String InputCode = request.getParameter("auth");
				
				boolean result = memberdao.checkpw(InputCode, HashedCode);
				System.out.println(result);
				out.write(String.valueOf(result));
				
				session.removeAttribute("authCode");
				
				return;
			}
			
			//포워딩 (디스패처 방식)
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
			}
		
		private static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 에러 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }
		
	    private static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }
	    
	    
	    private static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
		
		}
