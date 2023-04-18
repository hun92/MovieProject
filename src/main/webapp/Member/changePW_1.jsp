<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String contextPath = request.getContextPath();
    
    %>
    <style>
    	.findtb{
    		text-align: center;
    		width: 580px;
    		font-size: 1.2em;
    	}
    	
    	
    	.findtb input{
    		width: 70%;
    		height: 40px;
    	}
    	
    	.findtb p{
    		font-size : 0.7em;
    	}
    	
    	.joinf{
    		margin-top: 70px;
    	}
    	
    	.joinf button{
			background-color : gray;
			color : white;
			width : 15%;
			height: 40px;
			border-radius: 10px;
			margin-top: 40px;
		}
    	
    </style>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
	<div class="joinf">
	
	
	<a href="<%= contextPath%>/Crawling/maincenter.me">
	<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br>
	</a>
	
		<h2>비밀번호 변경</h2>
		
		<form class="form-signin" action="<%=contextPath%>/member1/changePW3.me" name="changePW" id="findPW" method="post">
		
		<table class="findtb">
			<tr>
				<td width="30%" style="text-align:right;">
					아이디&nbsp;&nbsp;
				</td>
				<td width="60%"style="text-align: left;">
					<input type="text" id="m_id" name="m_id" placeholder="아이디">
				</td>
				<td>
					<p id="idInput" style="color: green;"></p>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;">
					이메일&nbsp;&nbsp;
				</td>
				<td style="text-align: left;">
					<input type="text" id="m_email" name="m_email" placeholder="이메일">
				</td>
				<td>
					<p id="emailInput" style="color: green;"></p>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;">
					이름&nbsp;&nbsp;
				</td>
				<td style="text-align: left;">
					<input type="text" id="m_name" name="m_name" placeholder="이름">
				</td>
				<td>
					<p id="nameInput" style="color: green;"></p>
				</td>
			</tr>
			<tr id="change">
				<td style="text-align:right;">
					비밀번호 변경&nbsp;&nbsp;
				</td>
				<td height="70px" style="text-align: left;">
					<input type="password" name="m_pw" id="m_pw" placeholder="변경할 비밀번호를 입력하세요.">
					<p id="pwInput1" style="color: green;">비밀번호는 4자 이상 입력해주세요.</p>
				</td>
			</tr>
			<tr id="change2">
				<td style="text-align:right;">
					비밀번호 확인&nbsp;&nbsp;
				</td>
				<td height="70px" style="text-align: left;">
					<input type="password" name="pwCheck" id="pwCheck" placeholder="변경할 비밀번호를 다시 입력해주세요.">
				
					<p id="pwInput2" style="color: green;"></p>
				</td>
			</tr>
		</table>
		<input id="auth_btn" type="button" value="사용자 인증" onclick="check(); return false;">
		<input id="change_btn" type="button" value="비밀번호 변경" onclick="changeCheck(); return false;">
		<input type="button" value="취소" onClick="window.close();">
		</form>
		</div>
	</center>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		$("#change").hide();
		$("#change2").hide();
		$("#change_btn").hide();
		var pw1 = false;
		var pw2 = false;
		
		function check() {
			const m_id = $("#m_id").val();
			const m_name = $("#m_name").val();
			const m_email = $("#m_email").val();
			$.ajax({
				type: "post",
				async: true,
				url: "<%= contextPath %>/member1/changePW2.me",
				data: { m_name : m_name,
						m_id : m_id,
						m_email : m_email
				},
				dataType : "text",
				success : function(data) {
					if(data == "true") {
						$("#change").show();
						$("#change2").show();
						$("#auth_btn").hide();
						$("#change_btn").show();
					} else {
						alert("입력이 올바르지 않습니다.");
					}
				}
			})
		}
		
		//비밀번호 입력시 
	    $("#m_pw").focusout(function(){
	       if($("#m_pw").val().length < 4 ){
	    	   pw1 = false;
	             $("#pwInput1").text("한글,특수문자 없이 4글자 이상으로 작성해 주세요!").css("color","red");
	          }else{
	        	  pw1 = true;
	       	   $("#pwInput1").text("올바르게 입력되었습니다.").css("color","blue");
	          }
	    });
	    
	    //비밀번호 확인입력시 
	     $("#pwCheck").focusout(function(){
	        if($("#pwCheck").val().length < 4 ){
	              $("#pwInput2").text("4글자 이상으로 작성해 주세요!").css("color","red");
	           }else{
	        	   var pwd1 = $("#m_pw")
	               var pwd2 = $("#pwCheck");
	        	   
	        	   var pwdValue1 = pwd1.val();
	               var pwdValue2 = pwd2.val();
	        	   
	               if( pwd1.val() !==  pwd2.val()){
	                   $("#pwInput2").text("비밀번호가 일치하지 않습니다.").css("color","red");
	               		pw2 = false;
	               } else {
	                	pw2 = true;
	              	 	$("#pwInput2").text("올바르게 입력되었습니다.").css("color","blue");
	                }
	           }
	     });
	    
	    function changeCheck() {
	    	if(pw1 && pw2) {
	    		document.changePW.submit();
	    	} else {
	    		alert("비밀번호가 일치하지 않습니다.");
	    	}
	    }
	</script>
</body>
</html>