<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String contextPath = request.getContextPath();
    
    %>
    <style>
    	.Jointb{
    		text-align: center;
    	}
    	
    	.Jointb td{
    		height:70px;
    	}
    	
    	.Jointb input{
    		width: 250px;
    		height: 40px;
    	}
    	.Jointb button {
    		width : 160px;
    		height:30px;	
    		background-color : gray;
			color : white;
			border-radius: 10px;
			margin : 5px 0;
    	}
    	
    	.joinf{
    		margin-top: 70px;
    	}
    	
    	#sbmBtn{
			background-color : gray;
			color : white;
			width : 15%;
			height: 40px;
			border-radius: 10px;
			margin-top: 40px;
		}
    	
    	.ottdiv{
    		margin: 50px 0 50px 0;
    	}
    	
    	
    </style>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
</head>
<body>

<form action="<%=contextPath%>/member1/joinPro.me" class="form" method="post">

	<center>
	<div class="joinf">
	
	<a href="<%= contextPath%>/member1/main.me">
	<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br>
	</a>
	
	<div class="ottdiv">
			<img src="<%=contextPath%>/eq/img/1232.png" width="600px">
			</div>
	<h2>정보 입력</h2>
		<table class="Jointb">
			<tr>
				<td width="100px">
					닉네임
				</td>
				<td width="300px">	
					<input type="text" placeholder="닉네임을 적어주세요."
							   id="m_nickname" name="m_nickname">
				</td>
				<td align="left" width="300px"><p id = "nicknameInput" style="color: green;">닉네임은 2~20자로 한글, 영문자, 숫자를 포함할 수 있습니다.</p></td>
			</tr>
			<tr>
				<td>
					ID
				</td>
				<td>
					<input type="text" placeholder="아이디을 적어주세요."
							   id="m_id" name="m_id">
				</td>
				<td align="left" width="300px"><p id = "idInput" style="color: green;">아이디는 4~12자로 영문소문자와 숫자를 포함할 수 있습니다.</p></td>
			</tr>
			<tr>
				<td>
					PW
				</td>
				<td>
					<input type="password" placeholder="가입할 비밀번호를 적어주세요."
							   id="m_pw" name="m_pw"> 
				</td>
				<td align="left" width="300px"><p id = "pwInput1" style="color: green;">비밀번호는 4자 이상 작성해주세요.</td>
			<tr>
				<td>
					PW 확인
				</td>
				<td>
					<input type="password" placeholder="비밀번호를 다시 한번 적어주세요."
							   id="pwCheck" > 
				</td>
				<td align="left" width="300px"><p id = "pwInput2" /></td>
			</tr>
			<tr>
				<td>
					이름
				</td>
				<td>
					<input type="text" placeholder="이름을 적어주세요."
							   id="m_name" name="m_name"> 
				</td>
				<td align="left" width="300px"><p id = "nameInput" style="color: green;">이름은 2~20자로 한글 또는 영문 대소문자를 포함할 수 있습니다.</p></td>
			</tr>
			<tr>
				<td>
					이메일
				</td>
				<td>
				 	<input type="text" placeholder="이메일을 적어주세요."
							   id="m_email" name="m_email">
					<input id="authInput" type="text" placeholder="인증번호를 적어주세요">
					
				</td>
				<td align="left" width="300px">
					<button id="sendEmail" type="button">인증 메일 보내기</button><br>
					<button id="auth" type="button" >인증 확인</button>
				</td>
			</tr>
			<tr>
			<td></td>
				<td><p id = "emailInput" /></td> 
			</tr>
		</table>
			<button type="button" id="sbmBtn" onclick="check(); return false;" >회원가입 하기</button>
		</div>
	</center>
</form>





  <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
    var	nicknameC = false;
    var idC = false;
    var pwC = false;
    var pw2C = false;
    var nameC = false;
    var emailC = false;
    var authC = false;
    
     //닉네임 입력시 유효성검사 
     $("#m_nickname").focusout(function() {
    	//유효성 검사 부분 
     	var m_nickname = $("#m_nickname");
     	var m_nicknameValue = m_nickname.val();
    	var m_nicknameReg = RegExp(/^[가-힣a-zA-Z0-9]{2,20}$/);//2~20자 사이의 한글, 영문자, 숫자를 표함하는 문자열에 대응하는 정규표현식
     	var resultM_nickname = m_nicknameReg.test(m_nicknameValue);
        if(resultM_nickname == true){
       		//ajax 호출    
        	$.ajax(
                 {
                 type:"get", 
                  async:true, 
                  url:"<%=contextPath%>/member1/joinNicknameCheck.me",
                  data:{ m_nickname : m_nicknameValue },//서버페이지로 요청할 데이터설정
                  dataType:"text",
                  success : function(data) {
                    console.log(data);
                    
                    if (data == 'usable') {//닉네임이 DB에 없으면?(중복아님)
                       nicknameC = true;
                       $("#nicknameInput").text("사용할수 있는 닉네임 입니다.").css("color","blue");
                       
                    }else {//닉네임이 DB에 있으면? (입력한 닉네임이  DB에 저장되어 있다는 의미)
                       
                       $("#nicknameInput").text("사용할수 없는 닉네임 입니다.").css("color","red");
                       
                    }   
                 },//success 닫기
                 
                 error:function(){
                    alert("통신에러가 발생했습니다.");
                 }
                 
              }// json  {  } 닫기      
              
           );// $.ajax메소드 호출 부분 끝부분
           
        }else{
           $("#nicknameInput").text("닉네임 형식이 올바르지 않습니다!").css("color","red");
        }

     });
           
        
      //아이디  입력시 유효성검사 
     $("#m_id").focusout(function() {
        var m_id = $("#m_id");
        var m_idValue = m_id.val();
        var m_idReg = /^[a-z0-9]{4,12}$/;//4~12자 사이의 영문 소문자와 숫자를 포함하는 문자열에 대응하는 정규 표현식
        var resultM_id = m_idReg.test(m_idValue);
        if(resultM_id == true){      
               $.ajax({
                        type:"post", 
                        async:true, 
                        url:"<%=contextPath%>/member1/joinIdCheck.me", //요청할 주소
                        data:{ m_id : m_idValue },//서버페이지로 요청할 데이터 설정!
                        dataType:"text", 
                        success : function(data){
                           console.log(data);
                           if(data == 'usable'){ //아이디가 DB에 없으면?(중복아님)
                             idC = true;
                        		$("#idInput").text("사용할수 있는 id입니다.").css("color","blue");
                           }else{//아이디가 DB에 있으면? (입력한 아이디가  DB에 저장되어 있다는 의미)
                        	   idC = false;
                              $("#idInput").text("사용할수 없는 id입니다.").css("color","red");
                           }
                        },//success 닫기
                        error:function(){
                           alert("통신에러가 발생했습니다.");
                        }
                     }// json  {  } 닫기
                    ); // $.ajax메소드 호출 부분 끝부분  
            }else{
               $("#idInput").text("아이디 형식이 올바르지 않습니다!").css("color","red");
            }
     });
     //비밀번호 입력시 
     $("#m_pw").focusout(function(){
        if($("#m_pw").val().length < 4 ){
        	pwC = false;
              $("#pwInput1").text("한글,특수문자 없이 4글자 이상으로 작성해 주세요!").css("color","red");
           }else{
              pwC = true;
        	   $("#pwInput1").text("올바르게 입력되었습니다.").css("color","blue");
           }
     });
     
     //비밀번호 확인입력시 
     $("#pwCheck").focusout(function(){
        if($("#pwCheck").val().length < 4 ){
              $("#pwInput2").text("한글,특수문자 없이 4글자 이상으로 작성해 주세요!").css("color","red");
           }else{
        	   var pwd1 = $("#m_pw")
               var pwd2 = $("#pwCheck");
        	   
        	   var pwdValue1 = pwd1.val();
               var pwdValue2 = pwd2.val();
        	   
               if( pwd1.val() !==  pwd2.val()){
            	   pw2C = false;
                   $("#pwInput2").text("비밀번호가 일치하지 않습니다.").css("color","red");
                } else {
                	//비밀번호 정규표현식에 통과하고 비밀번호가 일치하면
                	pw2C = true;
              	 	$("#pwInput2").text("올바르게 입력되었습니다.").css("color","blue");
                }
           }
     });
      
      
     
     //이름
     $("#m_name").focusout(function(){
        var m_name = $("#m_name");
           var m_nameValue = m_name.val();
           var m_nameReg = RegExp(/^[가-힣a-zA-Z]{2,20}$/); //2~20자 사이의 한글 또는 영문 대소문자를 포함하는 문자열에 대응하는 정규 표현식
           var resultM_name = m_nameReg.test(m_nameValue);
     
        if(!resultM_name){
        	nameC = false;
        	$("#nameInput").text("이름을 2자 이상 한글 또는 영어를 사용하여 작성해주세요.").css("color","red");
           
        }else{
        	nameC = true;
           $("#nameInput").text("올바르게 입력되었습니다.").css("color","blue");
        }
     });
     
    //이메일 입력시 유효성검사 동일하게 
     $("#m_email").focusout(function() {
        var m_email = $("#m_email");
        
        var m_emailValue = m_email.val();
        
        var m_emailReg = /^\w{3,12}@[a-z]{2,10}[\.][a-z]{2,3}[\.]?[a-z]{0,2}$/; //이메일 정규표현식
        
        var resultM_email = m_emailReg.test(m_emailValue);
        
        if(resultM_email == true){      
               
               $.ajax( 
                     {
                        type:"post", 
                        async:true, 
                        url:"<%=contextPath%>/member1/joinEmailCheck.me", //요청할 주소
                        data:{ m_email : m_emailValue },//서버페이지로 요청할 데이터 설정!
                        dataType:"text", 
                        success : function(data){
                           console.log(data);
                           if(data == 'usable'){ //이메일이 DB에 없으면?(중복아님)
                              emailC = true;
                              $("#emailInput").text("사용할수 있는 email입니다.").css("color","blue");
                                    
                           }else{//이메일이 DB에 있으면?
                        	   emailC = false;
                              $("#emailInput").text("사용할수 없는 email입니다.").css("color","red");
                           }
                        },//success 닫기
                        error:function(){
                           alert("통신에러가 발생했습니다.");
                        }
                     }// json  {  } 닫기
                    ); // $.ajax메소드 호출 부분 끝부분  
            }else{
               $("#emailInput").text("이메일 형식이 올바르지 않습니다!").css("color","red");
            }

     });
     
    //0331 정태영 : 체크 함수 다이어트 시킴
    //앞서 각각의 input에서 포커스아웃 시키면 각각 별개의 변수에 true를 저장하고
    //모든 변수가 true이면 form이 submit
	function check() {
		if(idC && nicknameC && pwC && pw2C && nameC && emailC && authC) {
			console.log("1"+idC);
			console.log("2"+nicknameC);
			console.log("3"+pwC);
			console.log("4"+pw2C);
			console.log("5"+nameC);
			console.log("6"+emailC);
			console.log("7"+authC);
			$("form").submit();
		} else {
			console.log("1"+idC);
			console.log("2"+nicknameC);
			console.log("3"+pwC);
			console.log("4"+pw2C);
			console.log("5"+nameC);
			console.log("6"+emailC);
			console.log("7"+authC);
			alert("제대로 입력되지 않은 부분이 있습니다.");
		}
		return;
	}
    
    //이메일 인증 버튼 누르면 smtp를 통해 이메일이 전송되는 버튼
    $("#sendEmail").on("click", function(e) {
    	const email = $("#m_email").val();
    	const name = $("#_name").val();
    	if(emailC) {
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
    				$("#emailInput").text("인증이 완료되었습니다.").css("color","blue");
//     				$('#m_email').prop('readonly', true);
    				authC = true;
    			} else {
    				$("#emailInput").text("인증번호가 동일하지 않습니다.").css("color","red");
//     				$('#m_email').prop('readonly', false);
    				authC = false;
    			}
    		}
    	});
    })
    
    $("#m_email").keyup( (e) => {
    	authC = false;
    	$("#emailInput").val("");
    })
</script>	
</body>
</html>