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
	<style type="text/css">
		.bota{
			margin : auto;
			width : 80%;
			font-size: 1em;
			
		}
		
		.bbbot a{
			text-decoration: none;
			color: gray;
		}
		
		.bbbot p{
			color : gray;
		}
		
		
	</style>

</head>
<body>
	<center>
	<div class="bbbot">
	<hr style="border: solid 2px lightgray">
		<div class="bota">
			<a href="<%=contextPath%>/Crawling/boxOffice.me?menu=3"><strong>박스오피스</strong></a> |
			<a href="<%=contextPath%>/Crawling/youtubecenter.me"><strong>관련영상</strong></a> |
			<a href="<%=contextPath%>/com/listByRecent.bo?nowPage=0&nowBlock=0"><strong>커뮤니티</strong></a> |
			<a href="<%=contextPath%>/map/movieMap.mo"><strong>지도</strong></a>
		</div><br>
		<p>
			(주)무드무비  사업자 등록번호 214-98754-9874 <br>
			통신 판매업신고 번호 : 제 2021-경남-26호 <br>
			
			경상남도 양산시 양산역 1길 2 양산역프라자 202호<br><br>
			
			대표전화 : 010-0000-0000<br>
			
			FAX : 01-3546-9874
		</p>
		
		</div>
	</center>
</body>

</html>