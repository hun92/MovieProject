package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import VO.CommentVO;
import VO.CommunityVO;

//DB와 연결하여 비즈니스로직 처리 하는 클래스 
public class CommentDAO {
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	DataSource ds;
	
	//커넥션풀 생성 후 커넥션 객체 얻는 생성자
	public CommentDAO() {
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
	
	//댓글 등록!
	public void addComment(String m_nickname, String comment_nick, String comment_pw, String comment_content, String c_idx,
			String comment_uniqueid) {
			String sql = null;
			try {
				con = ds.getConnection();
				
				sql = "insert into com_comment (comment_idx, c_idx, comment_pw, m_nickname, comment_nick, comment_uniqueid, comment_content) "
						+ "values (comment_seq.nextVal,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, c_idx);
				pstmt.setString(2, comment_pw);
				pstmt.setString(3, m_nickname);
				pstmt.setString(4, comment_nick);
				pstmt.setString(5, comment_uniqueid);
				pstmt.setString(6, comment_content);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("addComment 메소드 내부에서 오류 !");
				e.printStackTrace();
			}finally {
				closeResource();
			}
	}
	
	
	//댓글 리스트 조회 해오기
	public ArrayList<CommentVO> listComment(String c_idx){
		ArrayList<CommentVO> clist = new ArrayList<CommentVO>();
		String sql = null;
		try {
			con = ds.getConnection();
			sql = "select * from com_comment where c_idx = ? order by comment_idx asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, c_idx);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CommentVO vo = new CommentVO();
				vo.setComment_idx(rs.getInt("comment_idx"));
				vo.setC_idx(rs.getInt("c_idx"));
				vo.setComment_pw(rs.getString("comment_pw"));
				vo.setM_nickname(rs.getString("m_nickname"));
				vo.setComment_nick(rs.getString("comment_nick"));
				vo.setComment_uniqueid(rs.getString("comment_uniqueid"));
				vo.setComment_content(rs.getString("comment_content"));
				vo.setReg_date(rs.getDate("reg_date"));
				
				clist.add(vo);
			}
		} catch (Exception e) {
			System.out.println("listComment 메소드 내부에서 오류 !");
			e.printStackTrace();
		}finally {
			closeResource();
		}
		
		
		return clist;
	}
	// 04/09 허상호 : 댓글 수정 , 삭제 요청시 비밀번호 확인하는 메소드
	public int pwCheck(String modPw,String commentIdx) {
		int result = 0;
		String sql = null;
		try {
			con = ds.getConnection();
			sql = "select COUNT(*) AS cnt from com_comment where comment_idx=? and comment_pw =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, commentIdx);
			pstmt.setString(2, modPw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("pwCheck 메소드 내부에서 오류 !");
			e.printStackTrace();
		}finally {
			closeResource();
		}
		
		return result;
	}
	// 04/09 허상호 : 댓글 수정 요청시
	public int modContentPro(String modRsContent, String modCommentIdx) {
		int modRs = 0;
		String sql = null;
		try {
			con = ds.getConnection();
			sql = "update com_comment set comment_content=? where comment_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, modRsContent);
			pstmt.setString(2, modCommentIdx);
			modRs = pstmt.executeUpdate();
		} catch(Exception e) {
			
		} finally {
			closeResource();
		}
		return modRs;
	}
	// 04/09 허상호 : 댓글 삭제 요청시
	public int delContentPro(String delPw, String commentIdx) {
		int delRs = 0;
		String sql = null;
		try {
			con = ds.getConnection();
			sql = "delete from com_comment where comment_idx=? and comment_pw=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, commentIdx);
			pstmt.setString(2, delPw);
			delRs = pstmt.executeUpdate();
			
		} catch(Exception e) {
			
		} finally {
			closeResource();
		}
		return delRs;
	}
	// 04/09 허상호 : 관리자 계정으로 댓글 삭제 요청시
	public int adminContentDel(String commentIdx) {
		int adminRs = 0;
		String sql = null;
		try {
			con = ds.getConnection();
			sql = "delete from com_comment where comment_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, commentIdx);
			adminRs = pstmt.executeUpdate();
			
		} catch(Exception e) {
			
		} finally {
			closeResource();
		}
		return adminRs;
	}
	
	
	
	

}









