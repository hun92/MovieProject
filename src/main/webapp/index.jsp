<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="center" value="${requestScope.center}"/>

  
<c:if test="${center == null}">
	<c:set var="center" value="Main/maincenter.jsp"/>
</c:if>




<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>무드무비</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">    
	    <meta http-equiv="content-type" content="text/html; charset=utf-8">
	    <meta name="author" content="Jobboard">
	    <!-- 타이틀 아이콘 -->
    	<link rel="shortcut icon" href="<%=contextPath%>/eq/img/micon.png">
    	<link href="<%=contextPath %>/eq/css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=contextPath %>/eq/css/sidebars.css" rel="stylesheet">
		<link href="<%=contextPath %>/eq/css/map.css" rel="stylesheet">
		
		<style type="text/css">
			
			.main{
				width: 100%;
				float: center;
			}
			
			
			.mainside{
				height: 98%;
				float : left;
				margin-left: 50px;
				text-align : left;
				position: fixed;
				border-radius: 20px;
				z-index: 3;
			}
			.maintext{
				width : 79%;
				margin-right: 20px;
				float : right;
				background-color: white;
				z-index: 2;
				box-shadow: 2px 2px 2px gray;
			}
			
			.mainbot{
				width : 79%;
				height: 28%;
				float : right;
				z-index: 1;
			}
			
			#ground{
				position: relative;
			    min-height: 100%;
			    margin: 0 auto;
			    padding-top: 7px;
				background-color: #585858;
			}
		
			.chatdiv{
			bottom: 3%;
			left: 4%;
			position: fixed;
			z-index: 4;
			}
		
			.chatingbtn{
			width: 60px;
			height: 60px;
			border-radius: 30px;
			font-size: 1.3em;
			border: none;
			background-color: white;
			color: gray;
			box-shadow: 0px 1px 3px gray;
		}
		 
		.chatingbtn:hover{
			background-color: gray;
			color:white;
		}
		
		
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
			function openChat(){
				var url = "<%=contextPath%>/Chat/chat.jsp";
				window.open(url,'채팅 화면','width=400px, height=690px');
				
			}
		
				 
			
		</script>
	</head>
	<body>
	<div id="ground">
		<input type="hidden" id="bgCol" value="write">
 		<center>
		<table class="main">
			<tr>
				<td class="mainside"><jsp:include page="Main/sidebar.jsp"/></td>	
				<td class="maintext"><jsp:include page="${center}" /></td>
			</tr>
			<tr>
				<td class="mainbot"><jsp:include page="Main/bottom.jsp"/> </td>
			</tr>
		</table>
		<div class="chatdiv">		
			<button onclick="openChat()" class="chatingbtn">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16">
				  	<path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
				</svg>
			</button>
		</div>
		
		</center>
	</div>	
	
	
	</body>
</html>