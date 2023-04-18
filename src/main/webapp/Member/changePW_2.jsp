<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String contextPath = request.getContextPath();
    
    %>
    <style>
    	.findtb{
    		text-align: center;
    		width: 800px;
    		font-size: 1.2em;
    	}
    	
    	.findtb input{
    		width: 250px;
    		height: 40px;
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
	
	
	<a href="<%= contextPath%>/member1/main.me">
	<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br>
	</a>
	
		<h2>비밀번호 변경</h2>
		
		<form class="form-signin" action="<%=contextPath%>/member1/changePW3.me" id="changePw" method="post">
		
		<table class="findtb">
			<tr>
				<td align="right" width="200px">
					변경할 비밀번호
				</td>
				<td align="left" width="200px">
					<input type="password" name="m_pw" id="m_pw" placeholder="변경할 비밀번호를 입력하세요.">
				</td>
				<td align="left" width="200px">
					<p id="pwInput1" style="color: green;">비밀번호는 4자 이상 입력해주세요.</p>
				</td>
				
			</tr>
			<tr>
				<td align="right" width="200px">
					비밀번호 확인
				</td>
				<td align="left" width="200px">
					<input type="password" name="pwCheck" id="pwCheck" placeholder="변경할 비밀번호를 다시 입력해주세요.">
				</td>
				<td align="left" width="200px">
					<p id="pwInput2" style="color: green;"></p>
				</td>
			</tr>
		</table>
		<input type="button" value="비밀번호 변경" onclick="submit();">
		<input type="button" value="취소" onClick="history.back();">
		</form>
		</a>
		</div>
	</center>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	//비밀번호 입력시 
    $("#m_pw").focusout(function(){
       if($("#m_pw").val().length < 4 ){
             $("#pwInput1").text("한글,특수문자 없이 4글자 이상으로 작성해 주세요!").css("color","red");
          }else{
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
                } else {
                	//비밀번호 정규표현식에 통과하고 비밀번호가 일치하면
                	pw2C = true;
              	 	$("#pwInput2").text("올바르게 입력되었습니다.").css("color","blue");
                }
           }
     });
	</script>
</body>
</html>