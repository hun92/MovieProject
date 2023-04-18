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
			height:50%;
			margin-top: 30px;
		}
	</style>
</head>
<body>
	<center>
		<div class="game">
			<img alt="지뢰찾기" src="<%=contextPath%>/eq/img/banner/minbanner.jpg" width="98%">
		<hr width="90%">
		<iframe width="1000" height="700" src="http://muan.github.io/emoji-minesweeper" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
		</div>
	</center>

</body>
</html>