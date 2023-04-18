<%@page import="VO.MemberVO"%>
<%@ page
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
%>	
<c:set var="contextPath" value="${ pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
		<style>
		
			.rankdiv{
				height: 700px;
			}
		
			.ranktb{
				width: 90%;
			}
			
			.ranktb tr{
				height: 40px;
				border-bottom: 1px gray solid;
			}
		</style>
		
	</head>
	<body>
	<center>
	<br><br>
		<div class="rankdiv">
		<img alt="박스오피스" src="<%=contextPath%>/eq/img/banner/rankbanner.jpg" width="98%">
		<hr>
		<table class="ranktb">
			<tr>
				<td>랭킹</td>
				<td>닉네임</td>
				<td>레벨</td>
				<td>누적 경험치</td>
				<td>가입일</td>				
			</tr>
			<c:set var="rank" value="1"/>
			<c:forEach var="memvo" items="${ list }">
				<tr>
					<td>${ rank }</td>
					<td>${ memvo.m_nickname }</td>
					<td>${ memvo.m_level }</td>	
					<td>${ memvo.m_exp }</td>
					<td>${ memvo.m_date }</td>			
				</tr>
				<c:set var="rank" value="${ rank + 1 }"/>
			</c:forEach>
		</table>
		</div>
		</center>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	</body>
</html>