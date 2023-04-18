<%@page import="VO.BoxCrawlingVO"%>
<%@page import="VO.CrawlingVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();	
%>    
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.108.0">
    <title>Center</title>
	<!-- 제이쿼리 사용을 위한 제이쿼리 라이이브러리 연동 -->

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Sunflower:wght@300&display=swap" rel="stylesheet">


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
   
	<script type="text/javascript" src="<%=contextPath%>/eq/js/main.js"></script>
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">

	<style type="text/css">
		.boxo{
			width: 98%;
			height: 120%;
			text-align: center;
			margin-top: 30px;
		}
		.boxo hr{
			width: 90%;
			border: 1.5px gray solid;
		}
		
		
		.boxtb{
			width: 100%;
			height: 500px;
			font-size: 0.8em;
		}
		
		.boxsmall{
			height:450px;
			text-align: center;
		}
		
		.tab{
			text-align: left;
			margin: auto;
		}
		
		a{
			color: black;
			text-decoration: none;
		}
		
		.movierank{
			width: 35px;
			height: 45px;
			background-color: yellow;
			font-size: 2.5em;
			position: absolute;
			margin : 0px 0px 0px 20px;
			font-family: 'Do Hyeon', sans-serif;
			border: white;
			color: black;
		}
		
		
	
	</style>
  
</head>
<body>

						<%
						 ArrayList list = (ArrayList)request.getAttribute("boxList");
						 BoxCrawlingVO vo = null;
						 String imgSrc;
						 String age;
						 String title; 
						 String dDate;
						 String people; 
						 %>
<center>

	<div class="boxo">
	<img alt="박스오피스" src="<%=contextPath%>/eq/img/banner/boxofficebanner.jpg" width="98%">

	<hr>
	<div>
		<table class="boxtb">
			<tr>
				<td>	
				<%
					for (int i = 0; i < 5; i++) {
						vo= (BoxCrawlingVO)list.get(i);
						imgSrc = vo.getImgSrc();
						age = vo.getAge();
						title = vo.getTitle();
						dDate = vo.getdDate();
						people = vo.getPeople();
				%>	 
					<td>	
					<div class="movierank">
					<b><%=i + 1%></b>
					</div>	
						<div class="boxsmall">
							<img src="<%=imgSrc%>" alt="" width="200px" />
							<br>
							<table class="tab"> 
								<tr>
									<td width="200px">
									<h5><b><%=title %></b></h5>
									</td>
								</tr>
								<tr>
									<td>	
									영화 관람가:<%=age%>
									</td>
								</tr>
								<tr>
									<td>
									<%=people%>
									</td>
								</tr>
								<tr>	
								<td>
									개봉일:<%=dDate%>
									</td>
								</tr>
							</table>
						</div>
									
				</td>
			<%	 
				}
						
			%>
			</tr>
		</table>
		<table class="boxtb">
			<tr>
				<td>	
				<%
					for (int i = 5; i < 10; i++) {
						vo= (BoxCrawlingVO)list.get(i);
						imgSrc = vo.getImgSrc();
						age = vo.getAge();
						title = vo.getTitle();
						dDate = vo.getdDate();
						people = vo.getPeople();
				%>	 
					<td>
					<div class="movierank">
					<b><%=i + 1%></b>
					</div>		
						<div class="boxsmall">
							<img src="<%=imgSrc%>" alt="" width="200px" />
							<br>
							<table class="tab"> 
								<tr>
									<td width="200px">
									<h5><b><%=title %></b></h5>
									</td>
								</tr>
								<tr>
									<td>	
									영화 관람가:<%=age%>
									</td>
								</tr>
								<tr>
									<td>
									<%=people%>
									</td>
								</tr>
								<tr>	
								<td>
									개봉일:<%=dDate%>
									</td>
								</tr>
							</table>
						</div>
									
				</td>
			<%	 
				}
						
			%>
			</tr>
		</table>
		<table class="boxtb">
			<tr>
				<td>	
				<%
					for (int i = 10; i < 15; i++) {
						vo= (BoxCrawlingVO)list.get(i);
						imgSrc = vo.getImgSrc();
						age = vo.getAge();
						title = vo.getTitle();
						dDate = vo.getdDate();
						people = vo.getPeople();
				%>	 
					<td>
					<div class="movierank">
					<b><%=i + 1%></b>
					</div>		
						<div class="boxsmall">
							<img src="<%=imgSrc%>" alt="" width="200px" />
							<br>
							<table class="tab"> 
								<tr>
									<td width="200px">
									<h5><b><%=title %></b></h5>
									</td>
								</tr>
								<tr>
									<td>	
									영화 관람가:<%=age%>
									</td>
								</tr>
								<tr>
									<td>
									<%=people%>
									</td>
								</tr>
								<tr>	
								<td>
									개봉일:<%=dDate%>
									</td>
								</tr>
							</table>
						</div>
									
				</td>
			<%	 
				}
						
			%>
			</tr>
		</table>
		<table class="boxtb">
			<tr>
				<td>	
				<%
					for (int i = 15; i < 20; i++) {
						vo= (BoxCrawlingVO)list.get(i);
						imgSrc = vo.getImgSrc();
						age = vo.getAge();
						title = vo.getTitle();
						dDate = vo.getdDate();
						people = vo.getPeople();
				%>	 
					<td>
					<div class="movierank">
					<b><%=i + 1%></b>
					</div>		
						<div class="boxsmall">
							<img src="<%=imgSrc%>" alt="" width="200px" />
							<br>
							<table class="tab"> 
								<tr>
									<td width="200px">
									<h5><b><%=title %></b></h5>
									</td>
								</tr>
								<tr>
									<td>	
									영화 관람가:<%=age%>
									</td>
								</tr>
								<tr>
									<td>
									<%=people%>
									</td>
								</tr>
								<tr>	
								<td>
									개봉일:<%=dDate%>
									</td>
								</tr>
							</table>
						</div>
									
				</td>
			<%	 
				}
						
			%>
			</tr>
			
			<table class="boxtb">
			<tr>
				<td>	
				<%
					for (int i = 20; i < 25; i++) {
						vo= (BoxCrawlingVO)list.get(i);
						imgSrc = vo.getImgSrc();
						age = vo.getAge();
						title = vo.getTitle();
						dDate = vo.getdDate();
						people = vo.getPeople();
				%>	 
					<td>	
					<div class="movierank">
					<b><%=i + 1%></b>
					</div>	
						<div class="boxsmall">
							<img src="<%=imgSrc%>" alt="" width="200px" />
							<br>
							<table class="tab"> 
								<tr>
									<td width="200px">
									<h5><b><%=title %></b></h5>
									</td>
								</tr>
								<tr>
									<td>	
									영화 관람가:<%=age%>
									</td>
								</tr>
								<tr>
									<td>
									<%=people%>
									</td>
								</tr>
								<tr>	
								<td>
									개봉일:<%=dDate%>
									</td>
								</tr>
							</table>
						</div>
									
				</td>
			<%	 
				}
						
			%>
			</tr>
		</table>
		
	</div>
</center>
</body>
</html>