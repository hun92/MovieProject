<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath(); 
	String modCommentIdx = request.getParameter("commentIdx");
	String modContent = request.getParameter("modContent");
%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정 창</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<style>
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100%;
}


</style>
</head>
<body>
<table class="container">
<tr>
<td width="100%">
<br>
	<input type="hidden" id="modCommentIdx" value="<%=modCommentIdx%>">

	<div id="pwCheckDiv" style="text-align:center;" class="input-group">
		<input type="password" id="comPwCheck" class="form-control" placeholder="댓글 비밀번호 입력">
		<button onclick="modPwCheck()" class="btn btn-outline-primary">확인</button>
	</div>
</td>	
</tr>
<tr>
	<td>
		<div>
			<p id="pwCheckInput"></p>
		</div>
	</td>
</tr>
<tr>
<td width="100%">	
	<div id="commentModDiv" style="display:none; ,text-align:center;">
			<textarea id="modRsContent" class="form-control" cols="100" rows="4"><%=modContent%></textarea>
			<button onclick="modContentPro()" class="btn btn-outline-primary" style="float:right">수정</button>
	</div>
</td>
		

</tr>
<tr>
	<td>
		<div class="asdasd">
			<p id="contentModInput"></p>
		</div>
	</td>
</tr>
</table>
</body>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		function modContentPro(){
			var modRsContent = $("#modRsContent").val();
			var modCommentIdx = $("#modCommentIdx").val();
			$.ajax({
				type: "post",
				async : true,
				url : "<%= contextPath %>/comment/modContentPro.bo",
				data : {
					modRsContent : modRsContent,
					modCommentIdx : modCommentIdx	
				},
				dataType : "text",
				success : function(data) {
					if(data == "ok"){
						window.opener.location.reload();  
						alert("글 수정 완료!")
						window.close(); 
					}else if(data == "no"){
						$("#contentModInput").text("관리자에게 문의주세요.").css("color","red");
					}
				}
			});
			
		}
	
		function modPwCheck(){
			var modPw = $("#comPwCheck").val();
			var commentIdx = $("#modCommentIdx").val();
			$.ajax({
				type: "post",
				async : true,
				url : "<%= contextPath %>/comment/pwCheck.bo",
				data : {
					modPw : modPw,
					commentIdx : commentIdx	
				},
				dataType : "text",
				success : function(data) {
					if(data == "ok"){
						$("#commentModDiv").css("display","block");
						$("#pwCheckDiv").css("display","none");
						$("#pwCheckInput").css("display","none");
					}else if(data == "no"){
						$("#comPwCheck").text("").focus();
						$("#pwCheckInput").css("display","block");
						$("#pwCheckInput").text("비밀번호가 일치하지 않습니다.").css("color","red");
					}
				}
			});
		}
	</script>	
	
</html>