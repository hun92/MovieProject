package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import VO.MemberVO;
import encryption.BCrypt;

//DB와 연결하여 비즈니스로직 처리 하는 클래스 
public class MemberDAO {
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	DataSource ds;
	//암호화 시키기 위한 map
	static Map<Character, Character> replacementMap;
	//복호화 시키기 위한 map
	static Map<Character, Character> reverse_replacementMap;
	
	//커넥션풀 생성 후 커넥션 객체 얻는 생성자
	public MemberDAO() {
		//map에 저장시킬 문자열 배열 2개를 준비, 첫 번째는 아스키코드의 순서 33~127까지이며, 두 번째는 그것을 랜덤하게 한 것이다.
		String[] arg = {"!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~"};
		String[] arg2 = {"?", "v", "0", ".", ",", "9", "o", "E", "&", "2", "a", "Q", "W", "1", "-", "y", "\\", "u", "8", "n", "f", "B", "I", "]", "/", "Y", ">", "%", "7", "C", "i", "'", "<", "~", "O", "Z", "[", "N", ";", "c", "4", "T", "!", "r", "D", "h", "X", "=", "z", "K", "F", "$", "(", "G", "+", "*", "J", "k", "|", "{", "q", "w", "\"", "m", "A", "P", "}", "b", "p", "H", "S", "_", "^", ")", "@", "g", "s", "t", "j", "`", "3", "U", "x", "#", "d", "l", "M", "6", "V", "L", "e", "R", "5", ":"};
		
		//for문을 이용하여 hashmap에 arg 배열을 key, arg2 배열을 value로 저장한다.
		replacementMap = new HashMap<Character, Character>();
		for(int i = 0; i < arg.length; i++) {
			replacementMap.put(arg[i].toCharArray()[0], arg2[i].toCharArray()[0]);
		}
		
		//replacementMap의 key와 value를 반대로 하여 저장한다.
	    reverse_replacementMap = new HashMap<Character, Character>();
	    for(Map.Entry<Character, Character> entry : replacementMap.entrySet()) {
	    	reverse_replacementMap.put(entry.getValue(), entry.getKey());
        }
		
		//context.xml파일에 설정한
		//Resource태그에 적힌  DataSource커넥션풀 객체 받아오기	
		try {
			//웹프로젝트의 디렉터리에 접근하기 위한 객체 생성
			Context ctx = new InitialContext();
			//커넥션풀 얻기 
			ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		
		} catch (Exception e) {
			System.out.println("DB연결 실패! - " + e);
		}	
	}
	
	//자원해제 기능
	private void closeResource() {
		if(con != null)try {con.close();} catch (Exception e) {e.printStackTrace();}
		if(pstmt != null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
		if(rs != null)try {rs.close();} catch (Exception e) {e.printStackTrace();}		
	}	
	
		//닉네임 중복 체크 !
		public boolean overlappedNickname(String m_nickname) {//입력한 닉네임를 매개변수 닉네임로 받는다
			
			boolean result = false;
			
			try {
				
				con = ds.getConnection();
				
				//오라클의 decode()함수를 이용하여 서블릿에서 전달되는
				//입력한 ID에 해당하는 데이터를 검색하여 true 또는 false를 반환하는데
				//검색한 갯수가 1(검색한 레코드가 존재하면)이면 'true'를 반환,
				//존재하지 않으면 'false'를 문자열로 반환하여 조회합니다.
				String sql = "select decode(count(*),1,'true','false') ";
					   sql	+= "as result from m_member";
					   sql  += " where m_nickname=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, m_nickname);
				
				rs = pstmt.executeQuery();
				
				rs.next();//조회된 제목줄에 커서(화살표)가 있다가 조회된 줄로 내려가 위치함
				
				String value = rs.getString("result");//"true"
				
				//문자열 "true" 또는 "false"를   Boolean자료형으로 형변환 하여 저장
				result = Boolean.parseBoolean(value);//true 또는 false
							
				//true -> 닉네임 중복
				//false-> 닉네임이 DB에 없으므로 중복 아님 
				
			}catch(Exception e) {

				System.out.println("overlappedNickname 메소드 내부에서 오류");
				e.printStackTrace();
			}finally {
				closeResource();//자원해제
			}
		
			return result;//true 또는 false를  MemberController로 반환 
		}
		
	//아이디 중복 체크 !
	public boolean overlappedId(String m_id) {//입력한 아이디를 매개변수 id로 받는다
		
		boolean result = false;
		
		try {
			
			con = ds.getConnection();
			
			//오라클의 decode()함수를 이용하여 서블릿에서 전달되는
			//입력한 ID에 해당하는 데이터를 검색하여 true 또는 false를 반환하는데
			//검색한 갯수가 1(검색한 레코드가 존재하면)이면 'true'를 반환,
			//존재하지 않으면 'false'를 문자열로 반환하여 조회합니다.
			String sql = "select decode(count(*),1,'true','false') ";
				   sql	+= "as result from m_member";
				   sql  += " where m_id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			
			rs.next();//조회된 제목줄에 커서(화살표)가 있다가 조회된 줄로 내려가 위치함
			
			String value = rs.getString("result");//"true"
			
			//문자열 "true" 또는 "false"를   Boolean자료형으로 형변환 하여 저장
			result = Boolean.parseBoolean(value);//true 또는 false
						
			//true -> 아이디 중복
			//false-> 아이디가 DB에 없으므로 중복 아님 
			
		}catch(Exception e) {

			System.out.println("overlappedId 메소드 내부에서 오류");
			e.printStackTrace();
		}finally {
			closeResource();//자원해제
		}
	
		return result;//true 또는 false를  MemberController로 반환 
	}
	
		//이메일 중복 체크 !
		public boolean overlappedEmail(String m_email) {//입력한 아이디를 매개변수 id로 받는다
			
			boolean result = false;
			
			try {
				
				con = ds.getConnection();
				
				//오라클의 decode()함수를 이용하여 서블릿에서 전달되는
				//입력한 ID에 해당하는 데이터를 검색하여 true 또는 false를 반환하는데
				//검색한 갯수가 1(검색한 레코드가 존재하면)이면 'true'를 반환,
				//존재하지 않으면 'false'를 문자열로 반환하여 조회합니다.
				String sql = "select decode(count(*),1,'true','false') ";
					   sql	+= "as result from m_member";
					   sql  += " where m_email=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, m_email);
				
				rs = pstmt.executeQuery();
				
				rs.next();//조회된 제목줄에 커서(화살표)가 있다가 조회된 줄로 내려가 위치함
				
				String value = rs.getString("result");//"true"
				
				//문자열 "true" 또는 "false"를   Boolean자료형으로 형변환 하여 저장
				result = Boolean.parseBoolean(value);//true 또는 false
							
				//true -> 아이디 중복
				//false-> 아이디가 DB에 없으므로 중복 아님 
				
			}catch(Exception e) {

				System.out.println("overlappedEmail 메소드 내부에서 오류");
				e.printStackTrace();
			}finally {
				closeResource();//자원해제
			}
		
			return result;//true 또는 false를  MemberController로 반환 
		}
	
		//회원가입 
		public void insertMember(MemberVO vo) {
		String pw = vo.getM_pw();
//		pw = pwdEncryption(pw);
//		pw = incodeBase64(pw);
		pw = hashpw(pw);
		
		try {
			//커넥션 풀에 만들어져 있는 DB와 미리 연결을 맺은 Connection객체 빌려오기 
			//요약 DB연결
			con = ds.getConnection();
			
			//insert문장 완성하기
			String sql = "INSERT INTO M_MEMBER (m_uniqueid, m_nickname, m_id, m_pw, m_name, m_email, m_gradeimage) " 
						+ "values(?, ?, ?, ?, ?, ?, 'egg.png')";
                         
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getM_uniqueid());
			pstmt.setString(2, vo.getM_nickname());
			pstmt.setString(3, vo.getM_id());
			pstmt.setString(4, pw);
			pstmt.setString(5, vo.getM_name());
			pstmt.setString(6, vo.getM_email());
			
			
			//PreparedStatement실행객체메모리에 설정된 inser2t전체 문장을 
			//DB의 테이블에 실행!
			pstmt.executeUpdate();
			
			//0324 정태영 레벨업 시스템을 위해 회원가입시 grade테이블을 생성함.
//			sql = "insert into grade values (1, ?, ?)";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, vo.getM_nickname());
//			pstmt.setString(2, vo.getM_uniqueid());
//			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertMember메소드 내부에서 SQL실행 오류 " + e);
			e.printStackTrace();
		} finally {
			closeResource(); //자원해제
		}
		
	}
	
	//입력한 아이디와 비밀번호를 매개변수로 받아  DB의 테이블에 저장되어 있는지 확인하는 메소드
	public int loginCheck(String m_id, String m_pw) {
		int check = -1;
		String hashedPW = null;
		try {
			//DB접속
			con = ds.getConnection();
			//매개변수로 로그인 아이디 받는 입력한 아이디에 해당되는 행을 조회 SELECT문
			String sql = "select * from M_member where m_id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//입력한 아이디로 조회한 행이 있으면?
				hashedPW = rs.getString("m_pw");
				//입력한 비밀번호와 조화된 비밀먼호와 비교 해서 있으면?
				if(checkpw(m_pw, hashedPW)) {
					check = 1;
				
				}else { //아이디는 맞고 비번 틀림
					check = 0;
				}
			}else {//아이디가 틀림
			check = -1;
			}
		} catch (Exception e) {
				System.out.println("loginCheck 메소드 내부에서 SQL문 실행 오류");
				e.printStackTrace();	
		}finally {
			closeResource();
		}
		return check;
		
		}
	

	//로그인후 사이드바 닉네이표시 
	public String logName (String m_id) {
		
		String nickname = null;
		
		try {
			con = ds.getConnection();
			
			String sql = "select m_nickname from m_member where m_id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
			nickname = rs.getString("m_nickname");
			}
		
		}catch (Exception e) {
			System.out.println("logName메소드 내부에서 SQL실행 오류 ");
			e.printStackTrace();
		} finally {
			//자원해제
			closeResource();
		}	
		
		return nickname;
		
	}
	
	
	//아이디찾기
		public String findId(String m_name, String m_email) {
	
			String m_id = null;
		
		try {
			
			con = ds.getConnection();
			
			String sql = "select m_id from m_member where m_name=? and m_email=?";
				
				pstmt = con.prepareStatement(sql);	
				
				pstmt.setString(1, m_name);
				pstmt.setString(2, m_email);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					
					m_id = rs.getString("m_id");
					
					
				}
					
		}catch (Exception e) {
			
			System.out.println("findId 메소드 내부에서 SQL문 실행 오류");
			e.printStackTrace();
			
		}finally {
			//자원해제
			closeResource();
		}
		
		return m_id;
		
	}
		//비밀번호찾기
		public String findPW(String m_name, String m_id, String m_email) {
			
			String m_pw = null;
			
			
			try {
				
				con = ds.getConnection();
				
				String sql = "select m_pw from m_member where m_name=? and m_id=? and m_email=?";
				
					pstmt = con.prepareStatement(sql);	
					
					pstmt.setString(1, m_name);
					pstmt.setString(2, m_id);
					pstmt.setString(3, m_email);
					
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						
						m_pw = rs.getString("m_pw");
					
					}
					
			}catch (Exception e) {
				
				System.out.println("findPw 메소드 내부에서 SQL문 실행 오류");
				e.printStackTrace();
				
			}finally {
				//자원해제
				closeResource();
			}
			
			return m_pw;
			
		}
	
	public int changePW(String m_name, String m_id, String m_email, String m_pw) {
		m_pw = hashpw(m_pw);
		int result = 0;
		try {
			con = ds.getConnection();
			String sql = "update m_member set m_pw = ? where m_name=? and m_id=? and m_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_pw);
			pstmt.setString(2, m_name);
			pstmt.setString(3, m_id);
			pstmt.setString(4, m_email);
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("changePW");
			e.printStackTrace();
		} finally {
			closeResource();
		}
		return result;
	}
		
	//회원 닉네임을을 이용해 회원 정보 조회
	public MemberVO findMember(String m_nickname) {
		
			MemberVO vo = null;
			
			try {
				//DB접속 : 커넥션풀에 만들어져 있는 커넥션 얻기
				con = ds.getConnection();
				
				String sql = "SELECT * FROM m_member WHERE m_nickname='"+ m_nickname+"'";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					
					vo = new MemberVO();
					vo.setM_id(rs.getString("m_id"));
					vo.setM_nickname(m_nickname);
					vo.setM_pw(rs.getString("m_pw"));
					vo.setM_name(rs.getString("m_name"));
					vo.setM_email(rs.getString("m_email"));
					vo.setM_date(rs.getDate("m_date"));
					vo.setM_exp(rs.getInt("m_exp"));
				}		
			}catch(Exception e) {
				System.out.println("findMember메소드 에서  SQL오류 : " + e);
			}finally {
				closeResource(); //자원 해제
			}
			return vo;//조회된 차량 한대정보가 저장된 CarConfirmVo객체를 CarController서블릿으로 반환!
	}
	
	//회원정보수정하는 메소드
	//입력한 회원정보를 수정하는 메소드 
		public int updateMember(MemberVO vo, String uniqueID) {
			int result = 0; //수정성공시 1이 저장되고 , 수정 실패하면 0이 저장될 변수 
			String updateColumn = null;
			String updateString = null;
			String sql = null;
			
			if(vo.getM_id() != null) {
				updateColumn = "m_id";
				updateString = vo.getM_id();
				sql = "update m_member set m_id = ? where m_uniqueid = ?";
			} else if(vo.getM_nickname() != null) {
				updateColumn = "m_nickname";
				updateString = vo.getM_nickname();
				sql = "update m_member set m_nickname = ? where m_uniqueid = ?";
			} else if(vo.getM_email() != null) {
				updateColumn = "m_email";
				updateString = vo.getM_email();
				sql = "update m_member set m_email = ? where m_uniqueid = ?";
			} else {
				updateColumn = "m_pw";
				updateString = vo.getM_pw();
				sql = "update m_member set m_pw = ? where m_uniqueid = ?";
			}
			System.out.println("dao.updateMember 변경할 행 이름 : " + updateColumn);
			System.out.println("dao.updateMember 변경할 값 이름 : " + updateString);
			
			try {
				con = ds.getConnection();
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, updateString);
				pstmt.setString(2, uniqueID);
				result = pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("updateMember");
				e.printStackTrace();
			} finally {
				closeResource();
			}
			
			return result;
		}
	
	//회원정보삭제시키는 메소드
	public int MemberDelete(String m_id, String m_pw) {
		
		int result = 0;
		
		try {
			con = ds.getConnection();
			
			String sql = "delete from m_member where m_id=? and m_pw=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setString(2, m_pw);
			
			result = pstmt.executeUpdate();
					
		} catch (Exception e) {
			System.out.println("MemberDelete메소드 내부에서 SQL실행 오류 ");
			e.printStackTrace();
		} finally {
			//자원해제
			closeResource();
		}	
		
		return result;
	}
	
	

	//닉네임 값을 이용해 멤버 한명의 정보를 가져오는 메소드
	public MemberVO getMemVO(String m_nickname) {
		
		MemberVO vo = null;
		
		
		
		try {
			con = ds.getConnection();
			String sql = "select * from m_member where m_nickname = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_nickname);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new MemberVO(	
									rs.getString("m_uniqueid"),
									rs.getString("m_nickname"),
									rs.getString("m_id"), 
									rs.getString("m_pw"), 
									rs.getString("m_name"),
									rs.getString("m_email"),
									rs.getInt("m_exp"),
									rs.getInt("m_level"),
									rs.getString("m_gradeimage")
									);
			}
		} catch(Exception e) {
			System.out.println("getMemVO");
			e.printStackTrace();
		} finally {
			closeResource();
		}
		return vo;	
	}
	
	//0327 정태영 : 고유id로 vo를 얻는 메서드
	public MemberVO getMemVOByUniqueID(String m_uniqueID) {
		
		MemberVO vo = null;
		
		try {
			con = ds.getConnection();
			String sql = "select * from m_member where m_uniqueid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_uniqueID);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new MemberVO(	
									rs.getString("m_uniqueid"),
									rs.getString("m_nickname"),
									rs.getString("m_id"), 
									rs.getString("m_pw"), 
									rs.getString("m_name"),
									rs.getString("m_email"),
									rs.getDate("m_date"),
									rs.getInt("m_exp"),
									rs.getInt("m_level"),
									rs.getString("m_gradeimage")
									);
			}
		} catch(Exception e) {
			System.out.println("getMemVO");
			e.printStackTrace();
		} finally {
			closeResource();
		}
		return vo;	
	}
	
	//0324 정태영 : 닉네임을 통해 GradeVO를 받을 수 있는 메서드
	//gradevo 삭제해서 안 쓸 거임
//	public GradeVO getGradeVO(String m_nickname) {
//		GradeVO vo = null;
//		try {
//			con = ds.getConnection();
//			String sql = "select * from grade where m_nickname = ?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, m_nickname);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				vo = new GradeVO(	
//									rs.getInt("m_level"),
//									rs.getString("m_nickname"),
//									rs.getString("m_uniqueid"),
//									rs.getInt("m_exp")
//						);
//			}
//		} catch(Exception e) {
//			System.out.println("getMemVO");
//			e.printStackTrace();
//		} finally {
//			closeResource();
//		}
//		return vo;	
//	}
	
	//0324 정태영 : 닉네임과 경험치 증가량을 매개변수로 받아 해당 닉네임의 사용자의 경험치를 해당 정수만큼 증가시켜 줌
//	public void updateExp(String nickname, int exp) {
//		try {
//				con = ds.getConnection();
//				String sql = "update m_member set m_exp = m_exp + ? where m_nickname = ?";
//				pstmt = con.prepareStatement(sql);
//				pstmt.setInt(1, exp);
//				pstmt.setString(2, nickname);
//				pstmt.executeUpdate();
//				
//			} catch(Exception e) {
//				System.out.println("updateExp");
//			} finally {
//				closeResource();
//			}
//	}
	
	//0325 정태영 : 회원가입 시 고유 id를 발급받는 메소드, 중복 체크 포함
	public int getUniqueid() {
		ArrayList list = new ArrayList();
		int uniqueID = 0;
		int check = 0;
		
		try {
			con = ds.getConnection();
			String sql = "select m_uniqueid from m_member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getInt("m_uniqueid"));
			}
			
			while(check == 0) {
				uniqueID = (int)(Math.random()*9000 + 1000);
				check++;
				for(int i = 0; i < list.size(); i++) {
					int oldID = (int)list.get(i);
					System.out.println("리스트의 값과 동일한지 확인하는 중입니다. 기존 고유 id : " + oldID + " 새로운 : " + uniqueID);
					if(uniqueID == oldID) {
						System.out.println("이미 존재하는 고유id입니다. 새로운 고유 id를 생성합니다.");
						check = 0;
					}
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeResource();
		}
		return uniqueID;
	}
	
	public int getUniqueID() {
		ArrayList list = new ArrayList();
		int uniqueID = 0;
		int check = 0;
		
		try {
			con = ds.getConnection();
			String sql = "select m_uniqueid from m_member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getInt("m_uniqueid"));
			}
			
			while(check == 0) {
				uniqueID = (int)(Math.random()*9000 + 1000);
				check++;
				for(int i = 0; i < list.size(); i++) {
					int oldID = (int)list.get(i);
					System.out.println("리스트의 값과 동일한지 확인하는 중입니다. 기존 고유 id : " + oldID + " 새로운 : " + uniqueID);
					if(uniqueID == oldID) {
						System.out.println("이미 존재하는 고유id입니다. 새로운 고유 id를 생성합니다.");
						check = 0;
					}
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeResource();
		}
		return uniqueID;
	}
	//레벨업 버튼 눌렀을 때
	public String updateLevel(int m_exp, String uniqueID, String gradeImage) {
		int insert_level = 1 + m_exp/100;
		System.out.println("레벨 : " + insert_level);
		String level = String.valueOf(insert_level);
		String sql = null;
		try {
			con = ds.getConnection();
			
			sql = "select rownum, m_uniqueid from m_member order by m_exp desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int i = 0;
			while(rs.next()) {
				i++;
				String rankerUniqueID = rs.getString("m_uniqueid");
				if(uniqueID.equals(rankerUniqueID)) {
					System.out.println("DAO, updateLevel 당신은 랭커입니다. 랭킹순위 : " + i);
					switch (i) {
					case 1:
						gradeImage = "gold_1.png";
						break;
					case 2:
						gradeImage = "gold_2.png";
						break;
					case 3:
						gradeImage = "gold_3.png";
						break;	
					default:
						break;
					}
				}
			}
			
			sql = "update m_member set m_level = ?, m_gradeimage = ? where m_uniqueid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, insert_level);
			pstmt.setString(2, gradeImage);
			pstmt.setString(3, uniqueID);
			pstmt.executeUpdate();
			level = String.valueOf(insert_level);
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("updateLevel");
		} finally {
			closeResource();
		}
		
		return level;
	}
	
	//0329 정태영 : 회원탈퇴 실행 눌렀을 때 기능
	public int withdrawalPro(String uniqueID) {
		int result = 0;
		try {
			con = ds.getConnection();
			String sql = "delete from m_member where m_uniqueid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uniqueID);
			result = pstmt.executeUpdate();
			
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("withdrawalPro");
		} finally {
			closeResource();
		}
		
		return result;
	}
	
	//0330 정태영 : 모든 멤버의 정보를 리스트로 담아 전달하는 메서드
	public List<MemberVO> getAllMemberList() {
		List list = new ArrayList();
		MemberVO vo = null;
		try {
			con = ds.getConnection();
			String sql = "select * from m_member order by m_exp desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new MemberVO(	
						rs.getString("m_uniqueid"),
						rs.getString("m_nickname"),
						rs.getString("m_id"), 
						rs.getString("m_pw"), 
						rs.getString("m_name"),
						rs.getString("m_email"),
						rs.getDate("m_date"),
						rs.getInt("m_exp"),
						rs.getInt("m_level"),
						rs.getString("m_gradeimage")
						);
				list.add(vo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeResource();
		}
		
		return list;
	}
	
	//0403 정태영 : 유저로부터 입력받은 비밀번호를 map을 이용해 암호화하는 메서드
	public static String pwdEncryption(String password) {
		StringBuilder encryptedBuilder = new StringBuilder();
        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            char encryptedChar = replacementMap.getOrDefault(c, c);
            encryptedBuilder.append(encryptedChar);
        }
        String encrypted = encryptedBuilder.toString();
        System.out.println("입력받은 문자열: " + password);
        System.out.println("암호화된 문자열: " + encrypted);
        return encrypted;
	}
	//0403 정태영 : 유저로부터 입력받은 비밀번호를 map을 이용해 복호화하는 메서드
	public static String pwdDecryption(String password) {
		StringBuilder decryptedBuilder = new StringBuilder();
        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            char decryptedChar = reverse_replacementMap.getOrDefault(c, c);
            decryptedBuilder.append(decryptedChar);
        }
        System.out.println("복호화된 문자열: " + decryptedBuilder.toString());
    	return decryptedBuilder.toString();
	}
	//0403 정태영 : base64를 이용해 인코딩 하는 메서드
	public static String incodeBase64(String pwd) {
    	String encoded = Base64.getEncoder().encodeToString(pwd.getBytes(StandardCharsets.UTF_8));
    	System.out.println("Base64를 이용해 incode 된 문자열: " + encoded);
    	return encoded;
    }
	//0403 정태영 : base64를 이용해 디코딩 하는 메서드
    public static String decodeBase64(String pwd) {
    	String decrypted = new String(Base64.getDecoder().decode(pwd.toString()), StandardCharsets.UTF_8);
    	System.out.println("DB에 저장된 비밀번호: " + pwd);
    	System.out.println("Base64를 이용해 decode 된 문자열: " + decrypted);
    	return decrypted;
    }
    //Bcrypt 라이브러리를 통해 암호화 하는 메서드
    public static String hashpw(String pwd) {
    	String salt = BCrypt.gensalt();
    	String hashedPassword = BCrypt.hashpw(pwd, salt);
    	
    	System.out.println("원래 비밀번호: " + pwd);
        System.out.println("소금: " + salt);
        System.out.println("암호화된 비밀번호: " + hashedPassword);
    	
    	return hashedPassword;
    }
    //Bcrypt 라이브러리를 이용해 암호를 확인하는 메서드
    //Bcrypt는 단방향이므로 암호의 복호화가 불가능하므로,
    //입력한 비밀번호가 DB에 저장된 비밀번호와 동일한지 여부만 알 수 있다.
    public static boolean checkpw(String pwd, String hashedPassword) {
    	String salt = BCrypt.gensalt();
//    	String hashedPassword = BCrypt.hashpw(pwd, salt);
    	boolean passwordMatches = BCrypt.checkpw(pwd, hashedPassword);
    	System.out.println("DB에 저장된 비밀번호: "+ hashedPassword);
    	System.out.println("비밀번호 동일 여부: "+ passwordMatches);
    	return passwordMatches;
    }
    
    public String getAuthCode() {
    	String ALLOWED_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+";
        int STRING_LENGTH = 4;
    	
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(STRING_LENGTH);
        for (int i = 0; i < STRING_LENGTH; i++) {
            int randomIndex = random.nextInt(ALLOWED_CHARACTERS.length());
            char randomChar = ALLOWED_CHARACTERS.charAt(randomIndex);
            sb.append(randomChar);
        }
        String randomString = sb.toString();
        System.out.println("dao, getAuthCode메서드를 통해 생성된 인증번호: "+randomString);
        
    	return randomString;
    }
    
    //유저의 고유아이디를 이용해 회원을 조회해 경험치를 업데이트한다. 주말일 경우 경험치가 2배로 추가된다.
    public int updateExp(String uniqueID, int exp, boolean wc) {
    	int result = 0;
    	if(wc) {
    		exp *= 2;
    	}
    	System.out.println("updateExp, "+uniqueID);
    	System.out.println("updateExp, "+exp);
    	System.out.println("updateExp, "+wc);
    	try {
    		con = ds.getConnection();
    		String sql = "update m_member set m_exp = m_exp + ? where m_uniqueid = ?";
    		pstmt = con.prepareStatement(sql);
    		pstmt.setInt(1, exp);
    		pstmt.setString(2, uniqueID);
    		result = pstmt.executeUpdate();
    		System.out.println("updateExp 완료");
    	} catch(Exception e) {
    		e.printStackTrace();
    	} finally {
    		closeResource();
    	}
    	return result;
    }

	public int insertKakaoMember(String kakao_name, String kakao_uniqueID, String kakao_email) {
		int result = 0;
		String kakao_id = "kakao_" + kakao_uniqueID;
		String kakao_nickname = "(kakao)" + kakao_name;
		System.out.printf("%s, %s, %s, %s, %s\n", kakao_uniqueID, kakao_name, kakao_id, kakao_name, kakao_email);
		
		try {
			con = ds.getConnection();
			String sql = "INSERT INTO M_MEMBER (m_uniqueid, m_nickname, m_id, m_pw, m_name, m_email, m_gradeimage) values(?, ?, ?, 'kakao_pw', ?, ?, 'egg.png')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, kakao_uniqueID);
			pstmt.setString(2, kakao_nickname);
			pstmt.setString(3, kakao_id);
			pstmt.setString(4, kakao_name);
			pstmt.setString(5, kakao_email);
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertKakaoMember");
			e.printStackTrace();
		} finally {
			
		}
		
		return result;
	}
	
	public int insertNaverMember(String naver_name, String naver_uniqueID, String naver_email) {
		int result = 0;
		String naver_id = "naver_" + naver_uniqueID;
		String naver_nickname = "(naver)" + naver_name;
		try {
			con = ds.getConnection();
			String sql = "INSERT INTO M_MEMBER (m_uniqueid, m_nickname, m_id, m_pw, m_name, m_email, m_gradeimage) values(?, ?, ?, 'naver_pw', ?, ?, 'egg.png')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, naver_uniqueID);
			pstmt.setString(2, naver_nickname);
			pstmt.setString(3, naver_id);
			pstmt.setString(4, naver_name);
			pstmt.setString(5, naver_email);
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertNaverMember");
			e.printStackTrace();
		} finally {
			
		}
		
		return result;
	}
	
	public int insertGoogleMember(String google_name, String google_uniqueID, String google_email) {
		int result = 0;
		String google_id = "google_" + google_uniqueID;
		String google_nickname = "(google)" + google_name;
		System.out.printf("%s, %s, %s, %s, %s\n", google_uniqueID, google_name, google_id, google_name, google_email);
		
		try {
			con = ds.getConnection();
			String sql = "INSERT INTO M_MEMBER (m_uniqueid, m_nickname, m_id, m_pw, m_name, m_email, m_gradeimage) values(?, ?, ?, 'google_pw', ?, ?, 'egg.png')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, google_uniqueID);
			pstmt.setString(2, google_nickname);
			pstmt.setString(3, google_id);
			pstmt.setString(4, google_name);
			pstmt.setString(5, google_email);
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertGoogleMember");
			e.printStackTrace();
		} finally {
			
		}
		
		return result;
	}
    
}

