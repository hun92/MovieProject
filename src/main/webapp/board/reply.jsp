<%@page import="VO.MemberVO"%>
<%@page import="java.sql.Date"%>
<%@page import="VO.CommunityVO"%>
<%@ page
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	MemberVO membervo = (MemberVO)request.getAttribute("membervo");
	String c_idx = (String)request.getAttribute("c_idx");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/ckeditor/ckeditor.js"></script>
		
		<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
		<script>
		
			
		</script>
		<style type="text/css">
			.replydiv{
				width : 99%;
				margin-top: 30px;
			}
			
			.replydiv hr{
				border : 1px gray solid;
				width : 90%
			}
			
			.replybox{
				width : 90%;
				margin : 40px 0 40px 0;
				padding: 30px;
			}
			
			.replybox button{
				border: 1px gray solid;
				background-color: white;
				width : 150px;
				height: 35px;
				border-radius: 10px;
			}
			
			.replybox button:hover{
				background-color: gray;
				color : white;
			}
			
			.replybox input{
				height: 30px;
				font-size: 1.2em;
				width : 90%;
			}
			
			.reptab{
				width : 90%;
				height : 800px;
			}
			
			
		</style>
	</head>
	<body>
	<center>
		<div class="replydiv">
			<img alt="글쓰기" src="<%=contextPath%>/eq/img/banner/replybanner.jpg" width="98%">
			<hr>
			<form name="reply" class="replybox" action="<%=contextPath %>/com/replyPro.bo">
			<table class="reptab">
			<tr>
				<td width="10%">
					제목 : 
				</td>
				<td width="40%">
					<input type="text" name="title">
				</td>
				<td width="10%">
					작성자 : 
				</td>
				<td width="40%">
				<c:choose>
		          	<c:when test="${ (membervo.m_nickname) != null}">
		          		<input type="text" name="writer" value="${ membervo.m_nickname }" readonly>
		          	</c:when>
		          	<c:otherwise>
			        	<input type="text" name="writer">
			      	</c:otherwise>
			   </c:choose>
				</td>
			</tr>
			<tr>
                <td colspan="4" style="text-align: left">
                	<textarea name="content" rows="20" cols="120" id="content"></textarea>
                	<script type="text/javascript">
					 	CKEDITOR.replace('content'
					                , {height: 500                                                  
					                 });
					</script>
                   	<p id="resultInput"></p>
				</td>
			</tr>
			<tr>
				<td>	
				비밀번호 : 
				</td><td>
				<input type="password" name="pass">
				</td>
			</tr>
				
			</table>
			<input type="hidden" name="c_idx" value="<%=c_idx%>">
			<button type="submit">게시</button>
			</form>
		</div>
	</center>	
	</body>
</html>