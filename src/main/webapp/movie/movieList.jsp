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
		.lista{
			width: 90%;
			text-align: left;
			margin-top: 50px;
		}
		
		.lista hr{
			border: 2px solid gray;
		}
	
		.list{
			width: 90%;
			text-align: left;
			height: 205px;
			border-bottom: 2px solid gray;
		}
		
		.listimg{
			width: 20%;
			float: left;
			height: 200px;
		}
		
		.listtext{
			width: 79%;
			float: right;
			height: 200px;
		} 
		
		.listtext h2{
			font-style: bold;
		}
		
		
	</style>
</head>
<body>
<center>
	<!-- 제목 시작 -->
	<div class="lista">
		<h1>영화</h1>
		<hr>
	</div>
	<!-- 제목 끝 -->
	<!-- 리스트 시작입니다~ -->
	<div class="list">
		<div class="listimg">
		<img src="<%=contextPath%>/eq/img/photo1.jpg" width="250px" height="200px">
		</div>
		<div class="listtext">
		<table>
			<tr>
				<td>
					<h2>컨저링</h2>
				</td>
			</tr>
			<tr>
				<td>
					평점
				</td>
			</tr>
			<tr>
				<td>
					예매율
				</td>
			</tr>
			<tr>
				<td>
					개봉일
				</td>
			</tr>
		</table>
		</div>
	</div>
	<!-- 리스트 끝! -->
	
	<div class="list">
		<div class="listimg">
		<img src="<%=contextPath%>/eq/img/photo1.jpg" width="250px" height="200px">
		</div>
		<div class="listtext">
		<table>
			<tr>
				<td>
					<h2>컨저링</h2>
				</td>
			</tr>
			<tr>
				<td>
					평점
				</td>
			</tr>
			<tr>
				<td>
					예매율
				</td>
			</tr>
			<tr>
				<td>
					개봉일
				</td>
			</tr>
		</table>
		</div>
	</div>
	
	
	<div class="list">
		<div class="listimg">
		<img src="<%=contextPath%>/eq/img/photo1.jpg" width="250px" height="200px">
		</div>
		<div class="listtext">
		<table>
			<tr>
				<td>
					<h2>컨저링</h2>
				</td>
			</tr>
			<tr>
				<td>
					평점
				</td>
			</tr>
			<tr>
				<td>
					예매율
				</td>
			</tr>
			<tr>
				<td>
					개봉일
				</td>
			</tr>
		</table>
		</div>
	</div>
	
	<div class="list">
		<div class="listimg">
		<img src="<%=contextPath%>/eq/img/photo1.jpg" width="250px" height="200px">
		</div>
		<div class="listtext">
		<table>
			<tr>
				<td>
					<h2>컨저링</h2>
				</td>
			</tr>
			<tr>
				<td>
					평점
				</td>
			</tr>
			<tr>
				<td>
					예매율
				</td>
			</tr>
			<tr>
				<td>
					개봉일
				</td>
			</tr>
		</table>
		</div>
	</div>
	
</center>	
</body>
</html>