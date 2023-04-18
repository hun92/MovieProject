<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String contextPath = request.getContextPath(); 
	String delCommentIdx = request.getParameter("commentIdx");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제 창</title>
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
		<div id="pwCheckDiv" class="input-group">
			<input type="password" id="comPwCheck" style="text-align:center;" class="form-control" placeholder="댓글 비밀번호">
			<button class="btn btn-outline-primary" onclick="delPwCheck()">삭제</button>
			<input type="hidden" id="delCommentIdx" value="<%=delCommentIdx%>">
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
</table>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
		function delPwCheck(){
			var delPw = $("#comPwCheck").val();
			var commentIdx = $("#delCommentIdx").val();
			$.ajax({
				type: "post",
				async : true,	
				url : "<%= contextPath %>/comment/delCommentPro.bo",
				data : {
					delPw : delPw,
					commentIdx : commentIdx	
				},
				dataType : "text",
				success : function(data) {
					if(data == "ok"){
						window.opener.location.reload();  
						alert("글 삭제 완료!")
						window.close(); 
					}else if(data == "no"){
						$("#comPwCheck").text("").focus();
						$("#pwCheckInput").text("비밀번호가 일치하지 않습니다.").css("color","red");
					}
				}
			});
		}
</script>
</html>