<%@page import="VO.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String contextPath = request.getContextPath();
    request.setCharacterEncoding("utf-8");
    	    	
    
    String m_id =  (String)request.getAttribute("m_id");
    
    %>
    <style>
    	.findtb{
    		text-align: center;
    		width: 400px;
    		font-size: 1.2em;
    	}
    	
    	.findtb input{
    		width: 250px;
    		height: 40px;
    	}
    	
    	.joinf{
    		margin-top: 70px;
    	}
    	
    	.joinf button{
			background-color : gray;
			color : white;
			width : 15%;
			height: 40px;
			border-radius: 10px;
			margin-top: 40px;
		}
    	
    </style>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
	<div class="joinf">
	
	<a href="<%= contextPath%>/member1/main.me">
	<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br>
	</a>
	
		<h2>아이디 찾기</h2>
		<h3>아이디는 <%=m_id%>입니다.</h3>
		<input type="button" value="홈으로" onclick="hone();" >		
		<input type="button" value="로그인" onclick="window.close();">
		</div>
	</center>
	<script>
	function hone() {
		window.opener.location.href="<%=contextPath%>/member1/main.me";  
		window.close();
	}
	</script>
</body>
</html>