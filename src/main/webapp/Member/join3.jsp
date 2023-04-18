<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String contextPath = request.getContextPath();
    
    %>
    <style>
    	
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
		
		.ottdiv{
    		margin: 50px 0 50px 0;
    	}
    	
    </style>
    
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
    
    
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
	
	<div class="ottdiv">
			<img src="<%=contextPath%>/eq/img/1233.png" width="600px">
			</div>
	<h2>회원가입이 완료 되었습니다!</h2>
		
		<a href="<%=contextPath%>/Member/login.jsp">
		<button>로그인</button>
		</a>
		</div>
	</center>
</body>
</html>