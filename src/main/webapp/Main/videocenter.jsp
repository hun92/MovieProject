<%@page import="VO.VideoCrawlingVO"%>
<%@page import="VO.BoxCrawlingVO"%>
<%@page import="VO.CrawlingVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String contextPath = request.getContextPath();

ArrayList list = (ArrayList) request.getAttribute("videoList");

VideoCrawlingVO vo = null;

String naver = "https://tv.naver.com";
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
<!-- 제이쿼리 사용을 위한 제이쿼리 라이이브러리 연동 -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript" src="<%=contextPath%>/eq/js/main.js"></script>
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">

<!-- 4.5 play heart 추가 -->
<style type="text/css">
	
	.test{
		text-align: center;
		width : 90%;
	}
	
	.videotab{
		width : 20%;
		height : 300px;
		border-bottom: 1px solid gray;
	}
	
	
	.videoimg{
		height : 170px;
		width : 100%;
		margin : auto;
		
	}
	
	.videotext{
		height : 70px;
		width : 100%;
	}
	
	.videolike{
		height : 40px;
		width : 100%;
		
	}
	
	.videotab:hover{
		border-radius: 15px;
		border: 1px solid red;
	}
	
	.videotext a{
		text-decoration: none;
		color : black;
	}
	
	.realimg{
		width : 230px;
		border-radius: 15px;
	}
	
	a{
		text-decoration: none;
	}
	
	
	.play{
		color:#E4E4E4;
	}
	
	.heart{
		color:#FF3636;
	}
</style>

</head>
<body>
	<center>
		<div>
			<br>
			<img alt="예고편" src="<%=contextPath%>/eq/img/banner/trailerbanner.jpg" width="98%">
			<hr>
				<table class="test">
					<tr class="videoground">
						<%
							for(int i=0; i<4; i++){
								vo = (VideoCrawlingVO) list.get(i);
								String playCnt = vo.getPlayCnt();
								String play = playCnt.replaceAll("[^0-9]","");
								String playlike = vo.getLike();
								String like = playlike.replaceAll("[^0-9]","");
						%>
						
						<td class="videotab">
						<div class="videoimg">
							<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
								<img src="<%=vo.getImgSrc()%>" class="realimg"/><br>
							</a>
						</div>
						<div class="videotext">
						<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
							<strong><%=vo.getTitle()%></strong><br>
						</a><!-- p부분 span,strong 추가 4.5-->
						</div>
						<div class="videolike">
						<p><span class="play">▶</span><strong><%=play%></strong>&nbsp;
						<span class="heart">♥</span>
						<strong><%=like%></strong>&nbsp;&nbsp;<%=vo.getUpload()%></p>
						</div>
						</td>
						<%} %>
					</tr>
					<tr>
						<%
							for(int i=4; i<8; i++){
								vo = (VideoCrawlingVO) list.get(i);
								String playCnt = vo.getPlayCnt();
								String play = playCnt.replaceAll("[^0-9]","");
								String playlike = vo.getLike();
								String like = playlike.replaceAll("[^0-9]","");
						%>
						
						<td class="videotab">
						<div class="videoimg">
							<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
								<img src="<%=vo.getImgSrc()%>" class="realimg"/><br>
							</a>
						</div>
						<div class="videotext">
						<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
							<strong><%=vo.getTitle()%></strong><br>
						</a><!-- p부분 span,strong 추가 4.5-->
						</div>
						<div class="videolike">
						<p><span class="play">▶</span><strong><%=play%></strong>&nbsp;
						<span class="heart">♥</span>
						<strong><%=like%></strong>&nbsp;&nbsp;<%=vo.getUpload()%></p>
						</div>
						</td>
						<%} %>
					</tr>
					<tr>
						<%
							for(int i=8; i<12; i++){
								vo = (VideoCrawlingVO) list.get(i);
								String playCnt = vo.getPlayCnt();
								String play = playCnt.replaceAll("[^0-9]","");
								String playlike = vo.getLike();
								String like = playlike.replaceAll("[^0-9]","");
						%>
						
						<td class="videotab">
						<div class="videoimg">
							<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
								<img src="<%=vo.getImgSrc()%>" class="realimg"/><br>
							</a>
						</div>
						<div class="videotext">
						<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
							<strong><%=vo.getTitle()%></strong><br>
						</a><!-- p부분 span,strong 추가 4.5-->
						</div>
						<div class="videolike">
						<p><span class="play">▶</span><strong><%=play%></strong>&nbsp;
						<span class="heart">♥</span>
						<strong><%=like%></strong>&nbsp;&nbsp;<%=vo.getUpload()%></p>
						</div>
						</td>
						<%} %>
					</tr>
					<tr>
						<%
							for(int i=12; i<16; i++){
								vo = (VideoCrawlingVO) list.get(i);
								String playCnt = vo.getPlayCnt();
								String play = playCnt.replaceAll("[^0-9]","");
								String playlike = vo.getLike();
								String like = playlike.replaceAll("[^0-9]","");
						%>
						
						<td class="videotab">
						<div class="videoimg">
							<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
								<img src="<%=vo.getImgSrc()%>" class="realimg"/><br>
							</a>
						</div>
						<div class="videotext">
						<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
							<strong><%=vo.getTitle()%></strong><br>
						</a><!-- p부분 span,strong 추가 4.5-->
						</div>
						<div class="videolike">
						<p><span class="play">▶</span><strong><%=play%></strong>&nbsp;
						<span class="heart">♥</span>
						<strong><%=like%></strong>&nbsp;&nbsp;<%=vo.getUpload()%></p>
						</div>
						</td>
						<%} %>
					</tr>
					<tr>
						<%
							for(int i=16; i<20; i++){
								vo = (VideoCrawlingVO) list.get(i);
								String playCnt = vo.getPlayCnt();
								String play = playCnt.replaceAll("[^0-9]","");
								String playlike = vo.getLike();
								String like = playlike.replaceAll("[^0-9]","");
						%>
						
						<td class="videotab">
						<div class="videoimg">
							<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
								<img src="<%=vo.getImgSrc()%>" class="realimg"/><br>
							</a>
						</div>
						<div class="videotext">
						<a href="<%=naver %><%=vo.getSrc()%>" target="_blank">
							<strong><%=vo.getTitle()%></strong><br>
						</a><!-- p부분 span,strong 추가 4.5-->
						</div>
						<div class="videolike">
						<p><span class="play">▶</span><strong><%=play%></strong>&nbsp;
						<span class="heart">♥</span>
						<strong><%=like%></strong>&nbsp;&nbsp;<%=vo.getUpload()%></p>
						</div>
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