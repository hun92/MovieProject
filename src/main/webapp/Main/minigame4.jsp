<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숫자야구게임</title>
		<script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="<%=contextPath %>/eq/css/baseBallGame.css" />
		<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
	</head>
	<body>

		<div id="title"> BASEBALL GAME </div>

		<!-- 입력 공간 생성 -->
		<header class="middle">
			<input type="text" class="inputNumber">
			<input type="text" class="inputNumber">
			<input type="text" class="inputNumber">
		</header>
		
		<main class="middle">
			<!-- 숫자를 입력할 버튼 생성 -->
			<div id="numberBox">
				<div class="numberBtn" onclick="pushBtn(1)">1</div>
				<div class="numberBtn" onclick="pushBtn(2)">2</div>
				<div class="numberBtn" onclick="pushBtn(3)">3</div>
				<br>
				<div class="numberBtn" onclick="pushBtn(4)">4</div>
				<div class="numberBtn" onclick="pushBtn(5)">5</div>
				<div class="numberBtn" onclick="pushBtn(6)">6</div>
				<br>
				<div class="numberBtn" onclick="pushBtn(7)">7</div>
				<div class="numberBtn" onclick="pushBtn(8)">8</div>
				<div class="numberBtn" onclick="pushBtn(9)">9</div>
			</div>
			<!-- 난수 생성은 랜덤 숫자를 만드는 버튼 -->
			<!-- 지우기는 입력한 숫자를 지우는 버튼 -->
			<!-- 플레이는 게임을 시작하는 버튼-->
			<div class="middle">
				<input type="button" value="난수 생성" class="fnBtn" onclick="createNum()">
				<input type="button" value="지우기" class="fnBtn" onclick="eraseNum()">
				<input type="button" value="플레이" class="fnBtn" onclick="playGame()">
			</div>
			<!-- 스트라이크(위치와 숫자가 맞는지)인지 볼(위치는 틀리고 숫자는 맞는지)인지 확인하는 부분 -->
			<p id="scoreBox" class="middle">
				<span id="strike">0</span>
				<span> Strike, </span>
				<span id="ball">0</span>
				<span> Ball. </span>
			</p>
		</main>
		<script>
		  //난수를 생성할 배열 변수 생성
		  var ans = [];
		  //입력공간에 숫자가 다 들어갔는지 확인하는 변수
	      var pushCnt = 0;
	      //입력공간에 숫자를 넣는 변수
	      var inputBox = document.getElementsByClassName("inputNumber");
	      //스크라이크인지 아닌지를 확인하는 변수
	      var strikeText = document.getElementById("strike");
	      //볼인지 아닌지 확인하는 변수
	      var ballText = document.getElementById("ball");
	      
	      //난수를 생성하는 함수
	      function createNum() {
	        do {
	          ans[0] = Math.floor(Math.random() * 9) + 1;
	          ans[1] = Math.floor(Math.random() * 9) + 1;
	          ans[2] = Math.floor(Math.random() * 9) + 1;
	        } while (ans[0] == ans[1] || ans[0] == ans[2] || ans[1] == ans[2]);

	        console.log(ans[0], ans[1], ans[2]);
	      }
		  
	      //숫자버튼을 눌러 위 입력 공간에 3개의 숫자가 들어갔는지 확인하는 함수
	      function pushBtn(num) {
	        if (pushCnt > 2) return;
	        inputBox[pushCnt++].value = num;
	      }
		  
	      //입력한 숫자를 지우고 스크라이크와 볼의 텍스트를 0으로 바꾸는 함수
	      function eraseNum() {
	        for (var i = 0; i < 3; i++) inputBox[i].value = "";
	        pushCnt = 0;
	        strikeText.innerText = "0";
	        ballText.innerText = "0";
	      }
		  
	      //입력공간이 비어 있는 지 확인하는 함수
	      function isBlank() {
	        for (var i = 0; i < 3; i++) {
	          if (inputBox[i].value == "") return 1;
	        }
	        return 0;
	      }
		  
	      //난수가 생성되지 않았을 경우 0을 반환 
	      //	 생성되었을때는 1을 반환 
	      function isRandomNumber() {
	        return ans[0] ? 0 : 1;
	      }
	      
		  //스크라이크인지 볼인지 확인하는 함수
		  //먼저 난수를 생성했는지 확인을 하고
		  //입력공간에 입력을 해야 실행가능한 함수
	      function playGame() {
	        if (isRandomNumber()) alert("난수를 생성해야 합니다.");
	        if (isBlank()) alert("모든 수를 입력해야 합니다.");
			
	        //Strike,Ball,num배열 초기화
	        var strike = 0,
	          ball = 0,
	          num = [];
	         
	        //num 배열공간에 
	        //입력공간에 들어온 숫자 확인
	        num[0] = document.getElementsByClassName("inputNumber")[0].value;
	        num[1] = document.getElementsByClassName("inputNumber")[1].value;
	        num[2] = document.getElementsByClassName("inputNumber")[2].value;
			
	        //난수와 입력한 숫자와 위치를 확인 후 맞으면 Strike에 +1
	        //난수와 입력한 숫자는 맞지만 위치가 틀릴 경우 Ball에 +1
	        //난수와 맞지 않은 경우엔 어느쪽도 증가하지 않는다.
	        for (var i = 0; i < 3; i++) {
	          for (var j = 0; j < 3; j++) {
	            if (ans[i] == num[j]) {
	              if (i == j) {
	            	  strike++;
	            	  if(strike == 3){
	            		  alert("3 STRIKE OUT!!!");
	            		  alert("♬♬GAME CLEAR♬♬");
	            	  }
	              }
	              else {
	            	  ball++;
	            	  
	              }
	            }
	          }
	        }
			//스크라이크의 갯수를 확인
	        strikeText.innerText = strike;
			//볼의 개수를 확인
	        ballText.innerText = ball;
	      }
		</script>
	</body>
</html>