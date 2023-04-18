<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Sunflower:wght@300&display=swap" rel="stylesheet">
	
	<style>
		.errorDiv{
			margin: 100px 0 0 0;
			border: 1px solid black;
			width : 500px;
			height: 500px; 
		}
		
		.errorDiv input{
			width: 19%;
			height: 10%;
			border: 1px solid black;
			background-color: white;
			border-radius: 15px;
			font-size : 1.2em;
			box-shadow: 1px 3px 3px gray;
			margin: 20px 5px;
			transition: all 0.1s linear;
		}
		
		.errorDiv input:hover{
			background-color: #F2F2F2;
			transform: scale(1.05);
		}
		
		
		.errorlogo{
			margin: 50px 0;
		}
		
		h1 {
			font-family: 'Do Hyeon', sans-serif;
			color : #585858;
		}
	</style>

</head>
<body>
	<center>
		<div class="errorDiv">
			<div class="errorlogo">
				<img alt="" src="<%=contextPath%>/eq/img/mm2.png" width="200px">
			</div>
			<h1>요청이 많아 접속이 지연되고 있습니다.<br> 다시 시도해 주세요.</h1>
			
			<input type="button" value="홈으로" onclick="window.location.href='<%=contextPath%>/Crawling/maincenter.me'">
			<input type="button" value="뒤로가기" onclick="history.go(-1)">
		</div>
	</center>

</body>
</html>