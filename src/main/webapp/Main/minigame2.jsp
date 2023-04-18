<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
	<style type="text/css">
		.game{
			width: 98%;
			height:98%;
			margin-top: 30px;
		}
	</style>
</head>
<body>
	<center>
		<div class="game">
		<img alt="핀볼" src="<%=contextPath%>/eq/img/banner/pinballbanner.jpg" width="98%">
		<hr width="90%">
		<iframe width="640" height="480" src="https://alula.github.io/SpaceCadetPinball/" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
		<div>
		<h2>키 설명</h2>
			<p>
				좌측 : 마우스왼쪽<br>
				우측 : 마우스오른쪽<br>
				발사 : 마우스휠 누르기
			</p>
		</div>
		
		</div>
	</center>

</body>
</html>