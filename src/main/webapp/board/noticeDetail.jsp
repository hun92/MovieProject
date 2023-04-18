<%@page import="VO.BoardLikeVO"%>
<%@page import="java.sql.Date"%>
<%@page import="VO.CommunityVO"%>
<%@ page
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"
%>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	CommunityVO vo = (CommunityVO)request.getAttribute("vo");
	String title = vo.getC_title();
	String writer = vo.getC_nickname();
	String content = vo.getC_content();
	Date writeDate = vo.getC_date();
	int views = vo.getC_views();
	int like = vo.getC_like();
	
	String nowPage = (String)request.getAttribute("nowPage");
	String nowBlock = (String)request.getAttribute("nowBlock");
	String c_idx = (String)request.getAttribute("c_idx");
  	String loginNick = (String)session.getAttribute("nickname");
  
	BoardLikeVO boardLikeVO = (BoardLikeVO)request.getAttribute("boardLikeVO");
	String check;
	
	if(boardLikeVO == null) {
		check = "no";
	} else {
		check = "yes";
	}	
%>

<%
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<style type="text/css">
	.boarddiv {
		margin-top: 50px;
		width : 90%;
		height: 1000px;
	}
			
	.boarddiv table{
		width : 60%;
		float : left;
	}
	
	.boardread{
		width : 30%;
		float : right;
		text-align: right;
	}
	
	.titlez{
		width : 100%;
		height : 50px;
		text-align : left;
		font-size: 1.5em;
		font-style: bold;
	}
	
	.textboxz{
		margin : 30px 0;
		height : 500px;
		width : 100%;
		text-align: left;
		border : none;
	}
	
	.repl{
		border : none;
		background-color: white;
	}
	
	#like_btn{
		border : none;
		background-color : white;
	}
	
	a{
		color: black;
		text-decoration: none;
	}
		</style>
		
	</head>
	<body>
	<center>
		<div class="boarddiv">
			<div class="titlez">
				<%= title %>
			</div>	
		<table>
		<tr>
			<td width="10%">
				<%= writer %>
			</td>
			<td>
				<%= writeDate %>
			</td>
			
		</tr>
		</table>
		<div class="boardread">
		 좋아요 : <%= like %> &nbsp;&nbsp;&nbsp; 조회수 : <%= views %>
		</div>
		<hr width="100%">	
			<textarea class="textboxz" readonly>
			<%= content %>
			</textarea>
			<p id="like">추천 수 : <%= like %></p>
			
			<button id="like_btn">
				<img id="likeimg" src="<%=contextPath%>/eq/img/good.png" width="100px">
			</button>
			
			<!-- 목록버튼 03/20 허상호 -->
			<div align="center">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/eq/img/listgo.png" border="0" width="100"/>
            	</a>
            </div>
		
		</div>
	</center>
		<script type="text/javascript">
		<!-- 목록버튼 클릭했을때 03/20 허상호 -->
		$("#list").click(function(event) {
			event.preventDefault();
			//community테이블에 저장된 글을 조회 하는 요청!
			location.href = "<%=contextPath%>/com/listByRecent.bo?nowPage=<%=nowPage%>&nowBlock=<%=nowBlock%>";
			
		})
		
			var check = "<%=check%>"
			if(check == "yes"){
				$("#like_btn").css({border : "red"});
				$("#likeimg").attr("src","<%=contextPath%>/eq/img/good2.png");
			}else{
				$("#like_btn").css({backgroundColor : "white"});
				$("#likeimg").attr("src","<%=contextPath%>/eq/img/good.png");
			}
			
			function replyBoard(val) {
				document.reply.action = "<%=contextPath%>/com/replyBoard.bo";
				document.reply.c_idx.value = val;
				document.reply.submit();
			}
			
			$("#like_btn").on("click", function() {
				if(check == "no") {
					$.ajax({
						type: "post",
						async : true,
						url : "<%= contextPath %>/com/noticeLike.bo",
						data : { c_idx : ${c_idx}},
						dataType : "text",
						success : function(data) {
							$("#like").text("추천 수 : "+data);
						}
					});
					check = "yes";
					$("#like_btn").css({border : "red"});
					$("#likeimg").attr("src","<%=contextPath%>/eq/img/good2.png");
					return;
				} else {
					$.ajax({
						type: "post",
						async : true,
						url : "<%= contextPath %>/com/noticeLikeCancel.bo",
						data : { c_idx : ${c_idx}},
						dataType : "text",
						success : function(data) {
							$("#like").text("추천 수 : "+data);
						}
					});
					check = "no";
					$("#like_btn").css({backgroundColor : "white"});
					$("#likeimg").attr("src","<%=contextPath%>/eq/img/good.png");
					return;
				}
			});
			
			
		</script>
	</body>
</html>