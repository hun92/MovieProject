<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String contextPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Sunflower:wght@300&display=swap" rel="stylesheet">

	<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Lato:300);

html, body {
     min-height: 100%;
}

.box{
	width: 100%;
	height: 730px;
  display: inline-block;
  text-align: center;
  position: relative;
  /*margin:0 -4px -5px -2px;*/
  transition: all .2s ease;
  background-color: gray;
}


/* MEDIA QUERIES */
@media (max-width: 700px){
  .box{
    width: 50%;
  }

  .box:nth-child(2n-1){
    background-color: inherit;
  }

  .box:nth-child(4n),.box:nth-child(4n-3) {
    background-color: rgba(0,0,0,0.05);
  }

}

@media (max-width: 420px){
  .box{
    width: 100%;
  }

  .box:nth-child(4n),.box:nth-child(4n-3){
    background-color: inherit;
  }

  .box:nth-child(2n-1){
    background-color:rgba(0,0,0,0.05);
  }

}


/* -------------- Clock -------------- */

.clock{
  border-radius: 60px;
  border: 3px solid #fff;
  height: 80px;
  width: 80px;
  position: relative;

  top: 28%;
  top: -webkit-calc(50% - 43px);
  top: calc(50% - 43px);
  left: 35%;
  left: -webkit-calc(50% - 43px);
  left: calc(50% - 43px);
}
.clock:after{
  content: "";
  position: absolute;
  background-color: #fff;
  top:2px;
  left: 48%;
  height: 38px;
  width: 4px;
  border-radius: 5px;
  -webkit-transform-origin: 50% 97%;
      transform-origin: 50% 97%;
  -webkit-animation: grdAiguille 2s linear infinite;
      animation: grdAiguille 2s linear infinite;
}

@-webkit-keyframes grdAiguille{
    0%{-webkit-transform:rotate(0deg);}
    100%{-webkit-transform:rotate(360deg);}
}

@keyframes grdAiguille{
    0%{transform:rotate(0deg);}
    100%{transform:rotate(360deg);}
}

.clock:before{
  content: "";
  position: absolute;
  background-color: #fff;
  top:6px;
  left: 48%;
  height: 35px;
  width: 4px;
  border-radius: 5px;
  -webkit-transform-origin: 50% 94%;
      transform-origin: 50% 94%;
  -webkit-animation: ptAiguille 12s linear infinite;
      animation: ptAiguille 12s linear infinite;
}

@-webkit-keyframes ptAiguille{
    0%{-webkit-transform:rotate(0deg);}
    100%{-webkit-transform:rotate(360deg);}
}

@keyframes ptAiguille{
    0%{transform:rotate(0deg);}
    100%{transform:rotate(360deg);}
}

.clocktext{
	color : white;
	font-family: 'Do Hyeon', sans-serif;
}

</style>
</head>	
<body onload="document.getElementById('myButton').click();">
	<center>
	   	<div class="box">
	      	<div class="clock"></div>
	      	<div class="clocktext">
	      		<h2>잠시만 기다려주세요...</h2>
	      	</div>
	      	 <button style="visibility:hidden" id="myButton" onclick="location.href='Crawling/maincenter.me'"></button>
	    </div>
	</center>

</body>
	
</body>
</html>