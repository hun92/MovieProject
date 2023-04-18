<%@page import="VO.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <%  
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	String m_id = (String)session.getAttribute("m_id");
	MemberVO vo = (MemberVO)request.getAttribute("vo");
	
	%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>회원정보</h1>
	<table align="center">
		<form action="<%=contextPath%>/member1/mypageUpdate.me" class="form" method="post">
		<tr>
			<td width="200"><p align="right">아이디</p></td>
			<td width="200"><p align="right"><%=vo.getM_id()%></p></td>
			<input type="hidden" name="id" value="<%=m_id%>">
		</tr>
		<tr>
			<td width="200"><p align="right">닉네임</p></td>
			<td width="200"><p align="right"><%=vo.getM_nickname() %></p></td>
		</tr>
		<tr>
			<td width="200"><p align="right">비밀번호</p></td>
			<td width="200"><p align="right"><%=vo.getM_pw() %></p></td>
		</tr>
		<tr>
			<td width="200"><p align="right">이름</p></td>
			<td width="200"><p align="right"><%=vo.getM_name() %></p></td>
		</tr>
		<tr>
			<td width="200"><p align="right">이메일</p></td>
			<td width="200"><p align="right"><%=vo.getM_email() %></p></td>
		</tr>
		<tr>
			<td width="200"><p align="right">가입일</p></td>
			<td width="200"><p align="right"><%=vo.getM_date() %></p></td>
		</tr>
		</form>
		<tr align="center">
			
			<td><a href="<%=contextPath%>/member1/main.me">뒤로가기</a></td>	
			<td><a href="#" onclick="check(); return false;">회원정보 수정하기</a></td>
			<td><a href="<%=contextPath%>/member1/delete.do">회원탈퇴</a></td>
			
		</tr>
	</table>
	  <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
    	function check(){
    		$("form").submit();
    	}
    </script>








</body>
</html>