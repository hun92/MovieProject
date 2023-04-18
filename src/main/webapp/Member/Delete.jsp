<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%
    request.setCharacterEncoding("utf-8");
    String contextPath = request.getContextPath();
    
	String m_id = (String)session.getAttribute("m_id");
	%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 삭제하기</title>
</head>
<body>

	<h1>회원삭제</h1>
	
	<form action="<%=contextPath%>/member1/signOut.me" method="post">
	
	<h3>정말로 삭제하시겠습니까?</h3>

	<input type="hidden" name="email" value="<%=m_id%>">

	<h3>비밀번호를 입력해주세요.</h3>
	<input type="password" name="pw"><br>
	
	<input type="submit" value="회원탈퇴" onClick="Delete(); return false;">
	<input type="button" value="홈으로" onClick="location.href='<%=contextPath%>/member1/main.me'">


	</form>
	
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	    <script type="text/javascript">
	    	function Delete(){
	    		$("form").submit();
	    	}
    </script>	




</body>
</html>