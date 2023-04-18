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
    
    <script type="text/javascript" src="<%=contextPath%>/eq/js/main.js"></script>
    
    <style>
    	.dt{
			width: 98%;
    		height: 500px;
    		
    	}
    	
    
    	.dtimg{
    		width: 35%;
    		height: 80%;
    		float:left;
    		margin-top: 20px;
    	}
    	
    	.dtable{
    		float: left;
    		text-align: left;
    		width: 50%;
    		height: 80%;
    	}
    	
    	.detail{
    		width: 50%;
    		text-align: left;
    		margin-top: 20px;
    	}
    	
    	
    	.detail h1{
    	font-size: 2em;
    	width: 300px;
    	text-align: left;
    	}
    	
    	.dteb{
    		width: 98%;
    		height: 30%;
    		text-align: left;
    		margin-left: 20px;
    	}
    	
    	.story{
    		margin-bottom: 50px;
    	} 
    	
    	.avi{
    		margin: auto;
    		float: center;
    		width: 700px;
    		height: 400px;
    		background-color: black;
    	}
    	
    	
    </style>
    
    
</head>
<body>
<center>
<!-- 상단영화 정보 영역쉬작 -->
	<div class="dt">
		<div class="dtimg">
			<img src="<%=contextPath%>/eq/img/123.jpg" width="300px">
		</div>
		<div class="detail">
			<h1>타이타닉</h1>
			<hr>
		<table class="dtable">
			
			<tr>
				<td width="100px">
					평점
				</td><td>	
					<img src="<%=contextPath%>/eq/img/SP.png">7.50
				</td>
			</tr>
			<tr>
				<td>
					감독
				</td>
				<td>
					모르는사람
				</td>
			</tr>
			<tr>
				<td>
					상영시간
				</td>
				<td>
					뒤지게 김
				</td>
			</tr>
			<tr>
				<td>
					주연
				</td>
				<td>
					안친한사람
				</td>
			</tr>
			<tr>
				<td>
					등급
				</td>
				<td>
					15세 관람가
				</td>
			</tr>
		</table>
		</div>
		
	</div>
	<!-- 상단영화 정보 영역끝 -->
	<!-- 줄거리 시작 -->
	<div class="dteb">
		<hr>
		<div class="story">
		<h3>줄거리</h3>
		<span>
			대충 배 가라앉는 내용, 비리가 가득찬 세상에서 귀족들은
			돈이 뒤지게 많아서 배타고 놀고 다니다가 배가 얼음에 부딪혀
			권선징악 당하는 내용임
		</span>
		</div>
		<hr>
	</div>
	<!-- 줄거리 끝 -->
	<div class="dteb">
		<div class="story">
		<h3>예고편</h3>
		<span>
			<div class="avi">
<iframe title="<스즈메의 문단속> 첫 번째 예고편" width="700" height="400" src="https://play-tv.kakao.com/embed/player/cliplink/430418376?service=player_share" allowfullscreen frameborder="0" scrolling="no" allow="autoplay; fullscreen; encrypted-media"></iframe>		</span>
		</div>
		<hr>
	</div>
	<div class="dteb">
		<div class="story">
		<h3>댓글</h3>
		<span>
			
		</span>
		</div>
		
	</div>
	
</center>	
</body>
</html>