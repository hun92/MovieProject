<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
    <%
    String contextPath = request.getContextPath();
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
	
	<a href="<%= contextPath%>/Crawling/maincenter.me">
	<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br>
	</a>
	
		<h2>비밀번호 변경</h2>
		<c:if test="${ result == 1 }">
			<h3>비밀번호는 변경이 완료되었습니다.</h3>
		</c:if>
		<c:if test="${ result != 1 }">
			<h3>비밀번호는 변경에 실패하였습니다.</h3>
		</c:if>
		
		<input type="button" value="홈으로" onclick="home();" >		
		<input type="button" value="로그인" onclick="window.close();">
		</a>
		</div>
	</center>
	<script>
	function home() {
		window.opener.location.href="<%=contextPath%>/member1/main.me";  
		window.close();
	}
	</script>
</body>
</html>