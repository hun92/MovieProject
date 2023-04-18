
<%@page import="VO.YoutubeCrawlingVO"%>
<%@page import="VO.VideoCrawlingVO"%>
<%@page import="VO.BoxCrawlingVO"%>
<%@page import="VO.CrawlingVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String contextPath = request.getContextPath();

ArrayList list = (ArrayList) request.getAttribute("youtubeList");

YoutubeCrawlingVO vo = null;

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.108.0">
<title>Center</title>

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Sunflower:wght@300&display=swap" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript" src="<%=contextPath%>/eq/js/main.js"></script>
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">

</head>
<body>
	<center>
		<div class="container">
			<br>
			<img alt="영상" src="<%=contextPath%>/eq/img/banner/videobanner.jpg" width="98%">
			<hr>
				<table class="Genretb">
					<div class="genreT">
						<h2>액션</h2>
					</div>
					<tr>
					
						<%
							for(int i=0; i<5; i++){
								vo = (YoutubeCrawlingVO) list.get(i);
								
								String title = vo.getTitle();
								if(title.length() > 25) {
									title = title.substring(0, 25) + "...";
								}
						%>
						
						<td class="genrepic">
						<a href="<%=vo.getHref()%>" target="_blank">
							<div class="genrego">
							<table class="genresmalltb">
							<tr><td height="140px">
							<div class="imgbor">
									<img src="<%=vo.getImgSrc()%>" class="imgbor" width="200px" height="130px" /><br>
							</div>
							</td></tr>
							<tr><td class="genretitle">
							<div class="genretitle2">
								<b><%=title%></b>
							</div>	
								<div class="gogogo">
									▶
								</div>
							</td></tr>
							</table>
							</div>
							</a>
						</td>
						<%} %>
					</tr>
				</table>
				<table class="Genretb">
				<div class="genreT">
						<h2>공포</h2>
					</div>
					<tr>
						<%
							for(int i=5; i<10; i++){
								vo = (YoutubeCrawlingVO) list.get(i);
								
								String title = vo.getTitle();
								if(title.length() > 25) {
									title = title.substring(0, 25) + "...";
								}
						%>
						
						<td class="genrepic">
						<a href="<%=vo.getHref()%>" target="_blank">
							<div class="genrego">
							<table class="genresmalltb">
							<tr><td height="140px">
							<div class="imgbor">
									<img src="<%=vo.getImgSrc()%>" class="imgbor" width="200px" height="130px" /><br>
							</div>
							</td></tr>
							<tr><td class="genretitle">
							<div class="genretitle2">
								<b><%=title%></b>
							</div>	
								<div class="gogogo">
									▶
								</div>
							</td></tr>
							</table>
							</div>
							</a>
						</td>
						<%} %>
					</tr>
					</table>
					<table class="Genretb">
					<div class="genreT">
						<h2>판타지</h2>
					</div>
					<tr>
						<%
							for(int i=10; i<15; i++){
								vo = (YoutubeCrawlingVO) list.get(i);
								
								String title = vo.getTitle();
								if(title.length() > 25) {
									title = title.substring(0, 25) + "...";
								}
						%>
						
						<td class="genrepic">
						<a href="<%=vo.getHref()%>" target="_blank">
							<div class="genrego">
							<table class="genresmalltb">
							<tr><td height="140px">
							<div class="imgbor">
									<img src="<%=vo.getImgSrc()%>" class="imgbor" width="200px" height="130px" /><br>
							</div>
							</td></tr>
							<tr><td class="genretitle">
							<div class="genretitle2">
								<b><%=title%></b>
							</div>	
								<div class="gogogo">
									▶
								</div>
							</td></tr>
							</table>
							</div>
							</a>
						</td>
						<%} %>
					</tr>
					</table>
					<table class="Genretb">
					<div class="genreT">
						<h2>로맨스</h2>
					</div>
					<tr>
						<%
							for(int i=15; i<20; i++){
								vo = (YoutubeCrawlingVO) list.get(i);
								
								String title = vo.getTitle();
								if(title.length() > 25) {
									title = title.substring(0, 25) + "...";
								}
						%>
						
						<td class="genrepic">
						<a href="<%=vo.getHref()%>" target="_blank">
							<div class="genrego">
							<table class="genresmalltb">
							<tr><td height="140px">
							<div class="imgbor">
									<img src="<%=vo.getImgSrc()%>" class="imgbor" width="200px" height="130px" /><br>
							</div>
							</td></tr>
							<tr><td class="genretitle">
							<div class="genretitle2">
								<b><%=title%></b>
							</div>	
								<div class="gogogo">
									▶
								</div>
							</td></tr>
							</table>
							</div>
							</a>
						</td>
						<%} %>
					</tr>
					</table>
					<table class="Genretb">
					<div class="genreT">
						<h2>스릴러</h2><!-- 4.10 수정 -->
					</div>
					<tr>
						<%
							for(int i=20; i<25; i++){
								vo = (YoutubeCrawlingVO) list.get(i);
								
								String title = vo.getTitle();
								if(title.length() > 25) {
									title = title.substring(0, 25) + "...";
								}
						%>
						
						<td class="genrepic">
						<a href="<%=vo.getHref()%>" target="_blank">
							<div class="genrego">
							<table class="genresmalltb">
							<tr><td height="140px">
							<div class="imgbor">
									<img src="<%=vo.getImgSrc()%>" class="imgbor" width="200px" height="130px" /><br>
							</div>
							</td></tr>
							<tr><td class="genretitle">
							<div class="genretitle2">
								<b><%=title%></b>
							</div>	
								<div class="gogogo">
									▶
								</div>
							</td></tr>
							</table>
							</div>
							</a>
						</td>
						<%} %>
					</tr>
					
					
				</table>
				<br>
				<br>
		</div>
		
	</center>
</body>
</html>