<%@page import="VO.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%  
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	MemberVO vo = (MemberVO)request.getAttribute("vo");
	
	%>
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
<style type="text/css">
			.mpdiv{
				width : 98%;
				margin : 100px 0 0 0;
			}
			
/* 			.mpdiv input{ */
/* 				margin : 5px 0 0 20px; */
/* 				height : 30px; */
/* 				width : 150px; */
/* 			} */
			
			.mptb{
				border : 1px solid black;
				width : 60%;
				height : 400px;
				float : right;
				margin : 20px 100px 0px 0px;
			}
			
			.mptb td{
				border : 1px solid gray;
				height : 19%;
				
			}
			
			.mptb button{
				background-color: gray;
				color: white;
				width: 80px;
				height: 30px;
				border-radius: 10px;
				margin: 3px 0 0 20px;
			}
			
			.profiletb{
				width : 20%;
				height : 400px;
				float : left;
				border : 3px solid gray;
				margin : 20px 0px 0px 100px;
				text-align: center;
			}
			
			
			.profimg {
			    width: 200px;
			    height: 200px; 
			    border-radius: 70%;
			    overflow: hidden;
			    margin: auto;
			}
			.profimg img{
			    width: 100%;
			    height: 100%;
			    object-fit: cover;
			}
			
			.btnbtn{
				margin : auto;
				width : 500px;
				height : 500px;
			}
			
			.btnbtn input{
				margin-top: 10px;
				width : 150px;
				height: 40px;
				background-color: gray;
				color : white;
				border-radius : 10px;
			}
			
			
			.emailcerti{
				width : 100%;
				height: 30px;
				border: none;
			}
			
			.emailcerti td{ 
				border: none; 
 			} 
			
			.emailText{
				width : 250px;
				height: 100%;
				align: center;
				margin: auto;
			}
			.emailBtn {
				width : 170px;
				height:30px;
				margin: auto 0 0 20px;
			}
			
			#m_id, #m_nickname, #m_pw, #m_email, #authInput{
				height: 30px;
			}
			
 			.smallmy p{ 
				margin:auto; 
 			} 
			
			.smallmy td {
			  display: table-cell;
			  vertical-align: middle;
			  border : none;
			}
			
		</style>

</head>
<body>
<center>
		<div class="mpdiv">
			<h1>회원 정보 수정</h1>
			<hr>
			<table class="mptb">
			<tr>
				<td width="10%">이름</td>
				<td width="40%" align="left">
				<input type="hidden" id="m_name" name="m_name"
					value="${ vo.m_name }" readonly>
				&nbsp;&nbsp;&nbsp;${ vo.m_name }	
				<p id="nameInput"></p>
				</td>
				
			<tr>
				<td>ID</td>
				<td>
				<table class="smallmy">
					<tr>
						<td>
							<input type="text" id="m_id" name="m_id" value="${ vo.m_id }" >
							<button type="button" onclick="updateID(); return false;">수정하기</button>
						</td>
						<td>
							<p id="idInput"></p>
						</td>
					</tr>
				</table>
				</td>
			</tr>	
				
			<tr>
				<td>닉네임</td>
				<td>
					<table class="smallmy">
					<tr>
						<td>
							<input type="text" id="m_nickname" name="m_nickname" value="${ vo.m_nickname }">
							<button type="button" onclick="updateNickname(); return false;">수정하기</button>						</td>
						</td>
						<td>
						<p id="nicknameInput"></p>
						</td>
						</tr>
				</table>
				</td>
			</tr>
		 
		 	<tr>	
				<td>Email</td>
				<td>
				<table class="emailcerti">
				<tr>
					<td>
						<input type="text" id="m_email" class="emailText" name="m_email"
							value="${ vo.m_email }">
						<input id="sendEmail" type="button" class="emailBtn" value="인증 메일 보내기">
					</td>
				</tr>
					<p id="emailInput"></p>
					<!-- 이메일 인증 관련 -->
				<tr>
					<td>
						<input id="authInput" type="text" class="emailText" placeholder="인증번호를 적어주세요">	
						<input id="auth" type="button" class="emailBtn" value="이메일 인증">
						<button type="button" onclick="updateEmail(); return false;">수정하기</button>
					</td>
				</tr>
				</table>
					
				</td>
			</tr>
			
			<tr>
				<td>비밀번호</td>
				<td>
					<table class="smallmy">
					<tr>
						<td>
						<input type="passWord" id="m_pw" name="m_pw" placeholder="비밀번호를 입력하세요.">						
						<button type="button" onclick="updatePW(); return false;">수정하기</button>						
						</td>
						<td>
						<p id="pwInput"></p>
						</td></tr>
				</table>
				</td>
			</tr>
		</table>
			
			<table class="profiletb">
					<tr>
						<td class="proftt">
						<div class="profimg">
							<img src="<%=contextPath%>/eq/img/pps.png">
						</div>
						</td>
					</tr>
					<tr>
						<td height="19%">
							<b><%=vo.getM_nickname()%></b>님
						</td>
					</tr>
				</table>
			
		 
		

		<div class="btnbtn">
			<a href="#" onclick="location.href='<%= contextPath %>/member1/mypage.me?userUniqueID=<%= vo.getM_uniqueid() %>'"; return false;">
				<input type="button" value="수정완료">
			</a>
		</div>
	</div>
</center>

  <script  src="http://code.jquery.com/jquery-latest.min.js"></script>	    
    <script type="text/javascript">
    let emailC = false;
    let authC = false;
    
    //0329 정태영 : 아이디 수정 함수
    function updateID() {
    	var m_id = $("#m_id");
     	var m_idValue = m_id.val();
    	var m_idReg = RegExp(/^[a-z0-9]{4,12}$/);
 	  	var resultM_id = m_idReg.test(m_idValue);
    	
 	  	if(resultM_id == true) {
 	  		$.ajax(
                 {
                 type:"post", 
                  async:true, 
                   url:"<%=contextPath%>/member1/joinIdCheck.me",
                  data:{ m_id : m_idValue, purpose : "change" },//서버페이지로 요청할 데이터설정
                  dataType:"text",
                  success : function(data) {
                    console.log(data);
                    
                    if (data == 'usable') {//닉네임이 DB에 없으면?(중복아님)
                       
                       $("#idInput").text("아이디 변경완료.").css("color","blue");
                       
                    }else {//닉네임이 DB에 있으면? (입력한 닉네임이  DB에 저장되어 있다는 의미)
                       
                       $("#idInput").text("아이디를 변경할 수 없습니다.").css("color","red");
                    }   
                 },//success 닫기
                 error:function(){
                    alert("통신에러가 발생했습니다.");
                 }
              }// json  {  } 닫기      
              
           );
 	  	}
 	  	//정규표현식에 해당하지 않는 경우
 	  	else {
 	  		$("#idInput").text("아이디를 형식에 맞게 작성해주세요!").css("color","red");
 	  	}
    }
    //0329 정태영 : 닉네임 수정 함수
    function updateNickname() {
    	var m_nickname = $("#m_nickname");
     	var m_nicknameValue = m_nickname.val();
    	var m_nicknameReg = RegExp(/^[가-힣a-zA-Z0-9]{2,20}$/);
 	  	var resultM_nickname = m_nicknameReg.test(m_nicknameValue);
    	
 	  	if(resultM_nickname == true) {
 	  		$.ajax(
                 {
                  type:"post", 
                  async:true, 
                  url:"<%=contextPath%>/member1/joinNicknameCheck.me",
                  data:{ m_nickname : m_nicknameValue, purpose : "change" },//서버페이지로 요청할 데이터설정
                  dataType:"text",
                  success : function(data) {
                    console.log(data);
                    
                    if (data == 'usable') {//닉네임이 DB에 없으면?(중복아님)
                       
                       $("#nicknameInput").text("닉네임 변경이 완료되었습니다.").css("color","blue");
                       
                    }else {//닉네임이 DB에 있으면? (입력한 닉네임이  DB에 저장되어 있다는 의미)
                       
                       $("#nicknameInput").text("아이디를 변경할 수 없습니다.").css("color","red");
                       
                    }   
                 },//success 닫기
                 
                 error:function(){
                    alert("통신에러가 발생했습니다.");
                 }
                 
              }// json  {  } 닫기      
              
           );
 	  	}
 	  	
 	  	else {
 	  		$("#nicknameInput").text("닉네임을 형식에 맞게 작성해주세요!").css("color","red");
 	  	}
    }
  //0329 정태영 : 비밀번호 수정 함수
    function updatePW() {
    	var m_pw = $("#m_pw");
	    var m_pwValue = m_pw.val();
	    var m_pwReg = /^[A-Za-z0-9_\-]{4,20}$/;
	    var resultM_pw = m_pwReg.test(m_pwValue);
	    if(resultM_pw == true){
	    	$.ajax( 
                 {
                    type:"post", 
                    async:true, 
                    url:"<%=contextPath%>/member1/joinPwCheck.me", //요청할 주소
                    data:{ m_pw : m_pwValue, purpose : "change" },//서버페이지로 요청할 데이터 설정!
                    dataType:"text", 
                    success : function(data){
                       console.log(data);
                       if(data == 'usable'){
                          $("#pwInput").text("비밀번호 변경 완료").css("color","blue");
                       }else{
                          $("#pwInput").text("사용할수 없는 비밀번호입니다.").css("color","red");
                       }
                    },//success 닫기
                    error:function(){
                       alert("통신에러가 발생했습니다.");
                    }
                 }// json  {  } 닫기
                ); // $.ajax메소드 호출 부분 끝부분  
	    } else {
	    	$("#pwInput").text("비밀번호를 작성해주세요!").css("color","red");
	    }
    }
    
  //0329 정태영 : 이메일 수정 함수
    function updateEmail() {
    	const m_email = $("#m_email");
	    const m_emailValue = m_email.val();
	    if(authC){
	    	$.ajax( 
                 {
                    type:"post", 
                    async:true, 
                    url:"<%=contextPath%>/member1/joinEmailCheck.me", //요청할 주소
                    data:{ m_email : m_emailValue, purpose : "change" },//서버페이지로 요청할 데이터 설정!
                    dataType:"text", 
                    success : function(data){
                       console.log(data);
                       if(data == 'usable'){ //아이디가 DB에 없으면?(중복아님)
                    	   $('#m_email').prop('readonly', false);
                          $("#emailInput").text("이메일 변경 완료").css("color","blue");
                          $("#authInput").val("");
                       }else{//아이디가 DB에 있으면? (입력한 아이디가  DB에 저장되어 있다는 의미)
                    	   $('#m_email').prop('readonly', true);
                    		$("#emailInput").text("사용할수 없는 이메일입니다.").css("color","red");
                       }
                    },//success 닫기
                    error:function(){
                       alert("통신에러가 발생했습니다.");
                    }
                 }// json  {  } 닫기
                ); // $.ajax메소드 호출 부분 끝부분  
	    } else {
// 	    	$("#emailInput").text("이메일 인증 완료 후 수정이 가능합니다.").css("color","red");
			alert("이메일 인증부터 해주세요");
	    	$("#authInput").attr("placeholder","이메일 인증부터 해주세요.");
	    	$("#authInput").focus();
	    }
    }
    
    $("#sendEmail").on("click", () => {
    	const email = $("#m_email").val();
    	const name = $("#_name").val();
    	
    	var m_email = $("#m_email");
	    var m_emailValue = m_email.val();
	    var m_emailReg = /^\w{3,12}@[a-z]{2,10}[\.][a-z]{2,3}[\.]?[a-z]{0,2}$/;
	    var resultM_email = m_emailReg.test(m_emailValue);
    	if(resultM_email == true) {
    		$.ajax({
    			type: "post",
    			async: true,
    			url: "<%=contextPath%>/member1/joinEmailCheck.me",
    			data: { m_email : email},
    			dataType: "text",
    			success: function(data) {
    				if(data == "usable") {
    					$.ajax({
    		    			type: "post",
    		    			async: true,
    		    			url: "<%= contextPath %>/member1/sendEmailAuth.me",
    		    			data: { m_email : email, m_name : name },
    		    			dataType: "text",
    		    			success: function(data) {
    		    				alert("인증 메일이 전송되었습니다. 인증번호를 기입하여 주십시오.");
    		    			}
    		    		});
    				} else {
    					alert("중복되는 이메일이 있으므로 사용이 불가합니다.");
    				}
    			}
    		});
    	} else {
    		alert("이메일을 양식에 맞게 작성해주세요.");
    	}
    })

    //인증메일을 확인
    $("#auth").on("click", function(e) {
    	const authInput = $("#authInput").val();
    	$.ajax ({
    		type: "post",
    		async: true,
    		url: "<%= contextPath %>/member1/emailAuth.me",
    		data: { auth : authInput },
    		dataType: "text",
    		success: function(data) {
    			if(data == "true") {
    				alert("인증이 확인되었습니다.");
    				$('#m_email').prop('readonly', true);
    				authC = true;
    			} else {
    				alert("인증번호가 동일하지 않습니다.");
    				$('#m_email').prop('readonly', false);
    				authC = false;
    			}
    		}
    	});
    })    
        
        
        
        
        
</script>	



</body>
</html>