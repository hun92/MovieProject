<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String token = (String)request.getAttribute("token");
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Sunflower:wght@300&display=swap" rel="stylesheet">

<script>
   const token = '<%= token %>';
   const jo = JSON.parse(token);
   
   const access_token = jo.access_token;
   const refresh_token = jo.refresh_token;
   const token_type = jo.token_type;
   const expires_in = jo.expires_in;
   
   console.log(access_token, refresh_token, token_type, expires_in);
   
   function login() {
      $.ajax({
         type: "get",
         async: true,
         url: "http://localhost:8090/greaitProject/member1/naverLoginPro.me?token="+access_token,
         data: {},
         dataType: "text",
         success: function(data) {
            const info = JSON.parse(data);
            const uniqueID = info.response.id;
            const name = info.response.name;
            const email = info.response.email;
            $.ajax({
               type: "get",
               async: true,
               url: "http://localhost:8090/greaitProject/member1/naverLoginProReal.me",
               data: { uniqueID : uniqueID,
                     name : name,
                     email : email
                     },
               dataType: "text",
               success: function(data) {
                  if(data == "1") {
                     location.href="http://localhost:8090/greaitProject/Crawling/maincenter.me";
                  } else {
                     return;
                  }
                  
               }
            })
         }
      })
   }
</script>

<style type="text/css">
	.loading{
		width : 60%;
		height: 600px;
	}
	
	.naverlogo{
		margin: 150px 0 0 0;
		width : 300px;
	}
	
	.naverloading{
		margin: 50px 0 0 0;
		height: 300px;
		font-family: 'Do Hyeon', sans-serif;
	}
	
	#circleLoading {
	  display: inline-block;
	  width: 80px;
	  height: 80px;
	  border: 3px solid rgba(255,255,255,.3);
	  border-radius: 50%;
	  border-top-color: #1DDB16;
	  animation: spin 1s ease-in-out infinite;
	  -webkit-animation: spin 1s ease-in-out infinite;
	}
	
	@keyframes spin {
	  to { -webkit-transform: rotate(360deg); }
	}
	@-webkit-keyframes spin {
	  to { -webkit-transform: rotate(360deg); }
	}
</style>
</head>
<body onload="document.getElementById('myButton').click();">
  <center>
		<div class="loading">
			<div class="naverlogo">
				<img width="250px" src="<%=contextPath%>/eq/img/naverlogogreen.png">
			</div>
			<div class="naverloading">
				<div id="circleLoading"></div><br><br>
				<h2>로그인중입니다. 잠시만 기다려주세요.</h2>
				 <button style="visibility:hidden" id="myButton" onclick="javascript:login()">ㄱ</button>
			</div>
		</div>
	</center>
</body>
</html>