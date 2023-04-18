<%@page import="VO.BoardLikeVO"%>
<%@page import="java.sql.Date"%>
<%@page import="VO.CommunityVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	String c_uniqueid = vo.getC_uniqueid();
	int views = vo.getC_views();
	int like = vo.getC_like();
	String nowPage = (String)request.getAttribute("nowPage");
	String nowBlock = (String)request.getAttribute("nowBlock");
	String c_idx = (String)request.getAttribute("c_idx");
  	String loginNick = (String)session.getAttribute("m_nickname");
  	String viewId = (String)session.getAttribute("m_uniqueID");
	BoardLikeVO boardLikeVO = (BoardLikeVO)request.getAttribute("boardLikeVO");
	String check;
	System.out.println("세션값 : "+loginNick);
	if(boardLikeVO == null) {
		check = "no";
	} else {
		check = "yes";
	}
	if(nowPage == null || nowBlock == null){
		nowPage="0";
		nowBlock="0";
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
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
		<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
    	<link href="<%=contextPath %>/eq/css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=contextPath %>/eq/css/sidebars.css" rel="stylesheet">
		<style type="text/css">
		
		
	.tblListComment {
    /* 댓글 리스트 div의 크기가 고정되어 있을 경우, 스크롤바를 추가하여 내용을 볼 수 있게 합니다. */
   		 height: 400px;
    	overflow-y: scroll; /* 세로 스크롤바를 표시합니다. */
	}
	#tblAddCommnet, #tblListComment { width: 700px; margin: 15px auto; }
	
	#tblAddComment { margin-top: 30px; }
	#tblAddComment td:nth-child(1) { width: 600px; }
	#tblAddComment td:nth-child(2) { width: 100px; }
	
	#tblListComment td:nth-child(1) { width: 600px; }
	#tblListComment td:nth-child(2) { width: 100px; }
	
	#tblListComment td {
		position: relative;
		left: 0;
		top: 0;
	}
	
	#tblListComment td span {
		position: absolute;
		right: 10px;
		bottom: 5px;
		color: #AAA;
		font-size: 11px;
	}
	.boarddiv {
		margin-top: 50px;
		width : 90%;
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
		margin-left: 5%;
	}
	
	.textboxz{
		margin : 30px 0;
		height : 500px;
		width : 100%;
		text-align: left;
		border : none;
		padding: 50px;
	}
	
	
	.repl{
		border : none;
		background-color: white;
	}
	
	#like_btn{
		border : none;
		background-color : white;
	}
	
	
	.banner{
		margin-top: 30px;
	}
	.button-wrapper {
	  display: flex;
	  justify-content: space-between;
	  width: 20%;
	}
	
	.commentTb{
		width : 85%;
		
	}
	.comment_td{
		width:30%;
  }
	.writeinfo{
		width: 90%;
		border-bottom: 2px solid gray;
	}

	#comment_submit{
		height : 100px;
		width : 80px;
  }
  
	a{
		text-decoration: none;
	}
	
		</style>
		
	</head>
	<body onload="getListComment();">
	<center>
		<div class="banner">
			<img alt="컨텐츠" src="<%=contextPath%>/eq/img/banner/contentsbanner.jpg" width="98%">
		</div>
		<div class="boarddiv">
			<div class="titlez">
				<%= title %>
			</div>
			<table class="writeinfo">
				<tr width="100%">
					<td width="50%">
						<%= writer %>
					</td>
					<td width="20%">
					 <%= writeDate %>
					</td>
					<td width="15%">
						좋아요 : <%= like %>
					</td>
					<td width="15%">
						조회수 : <%= views %>
					</td>
				</tr>
			</table>
			
			<div class="textboxz">
				<%= content %>
			</div>
			<hr>
			<p id="like">추천 수 : <%= like %></p>
			
			<div class="button-wrapper">
			  <button id="like_btn">
			    <img id="likeimg" src="<%=contextPath%>/eq/img/good.png" width="100px">
			  </button>
			  <form name="reply" action="<%=contextPath%>/com/replyBoard.bo">
			    <input type="hidden" name="c_idx" value="<%=c_idx%>">
			    <input type="hidden" name="nowPage" value="<%=nowPage%>">
			    <input type="hidden" name="nowBlock" value="<%=nowBlock%>">
			    <button type="submit" class="repl">
			      <img src="<%=contextPath%>/eq/img/ment.png" width="100px">
			    </button>
			  </form>
			</div>
			<% if (loginNick != null){ //로그인을 했을경우%>
				<%if (loginNick.equals("admin")){//닉네임이 admin인 관리자계정으로 로그인 했을때 %>
			<!-- 목록버튼 03/20 허상호 -->
			<div align="center" style="margin: 100px 0 0 0;">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/eq/img/listgo.png" border="0" width="100"/>
            	</a>
            	<!--  삭제버튼 04/02 허상호 -->
            	<a href="javascript:(0);" id="delete" onclick="boardRequest('adminDelete');">
            		<img src="<%=contextPath%>/eq/img/condelete.png" width="100px">
            	</a>
            </div>
            	
			<%}else if(c_uniqueid.equals(viewId)){// 관리자계정 말고 다른 계정으로 로그인했을때 본인글%>
				
				<div align="center" style="margin: 100px 0 0 0;">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/eq/img/listgo.png" border="0" width="100"/>
            	</a>
            	<!--  수정버튼 04/02 허상호 -->
            	<a href="javascript:(0);" id="mod" onclick="boardRequest('mod');">
            		<img src="<%=contextPath%>/eq/img/revive.png" border="0" width="100"/>
            	</a>
          		<!--  삭제버튼 04/02 허상호 -->
            	<a href="javascript:(0);" id="delete" onclick="boardRequest('delete');">
            		<img src="<%=contextPath%>/eq/img/condelete.png" width="100px">
            	</a>
            </div>
				
		    <%  }else{//로그인후 다른사람글 들어왔을때 %>
	    	<div align="center" style="margin: 100px 0 0 0;">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/eq/img/listgo.png" border="0" width="100"/>
            	</a>
            </div>
		   	 <%}
			}else if(c_uniqueid.equals(viewId) ){ //비회원일때 본인이 작성한 글에 들어왔을때 %>	
			<!-- 목록버튼 03/20 허상호 -->
			<div align="center" style="margin: 100px 0 0 0;">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/eq/img/listgo.png" border="0" width="100"/>
            	</a>
            	<!--  수정버튼 04/02 허상호 -->
            	<a href="javascript:(0);" id="mod" onclick="boardRequest('mod');">
            		<img src="<%=contextPath%>/eq/img/revive.png" border="0" width="100"/>
            	</a>
          		<!--  삭제버튼 04/02 허상호 -->
            	<a href="javascript:(0);" id="delete" onclick="boardRequest('delete');">
            		<img src="<%=contextPath%>/eq/img/condelete.png" width="100px">
            	</a>
            </div>
			<%}else{ //비회원일때 다른사람이 작성한 글에 들어왔을때%>
			<!-- 목록버튼 03/20 허상호 -->
			<div align="center" style="margin: 100px 0 0 0;">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/eq/img/listgo.png" border="0" width="100"/>
            	</a>
            </div>
			<%} %>
			<!-- 04/02 허상호 글 수정 삭제 요청시 비밀번호 입력 받는 공간 -->
			<form name="updateForm" align="center" style="visibility:hidden" id="updateForm" method="post">
            	<input type="hidden" name="c_idx" value="<%=c_idx%>">
            	<input type="hidden" name="nowPage" value="<%=nowPage%>">
            	<input type="hidden" name="nowBlock" value="<%=nowBlock%>">
            	<input type="password" name="updatePw" id="updatePw">
            	<input type="submit" value="확인">
         	</form>
         </div>
         <hr><hr>
        <%-- 댓글 작성 --%>
         <form method="post" id="comment_write">
			<table class="commentTb">
				<tr>
					<td class="comment_td">
					  <% if(loginNick != null){//로그인을 했을때%>
					  <input type="text" class="form-control" id="m_nickname" name="m_nickname" value="<%=loginNick%>" readonly><br>
					   <%}else{//로그인을 하지 않았을때%>
					   <input type="text" class="form-control" id="comment_nick" name="comment_nick" placeholder="닉네임"><br>
					   <%}%>
					  <input type="password" class="form-control" id="comment_pw" name="comment_pw" placeholder="댓글 비밀번호">
					 </td>
					 <td width="60%">
						  <textarea id="comment_content" class="form-control" name="comment_content" rows="4" cols="110" placeholder="댓글을 남겨주세요."></textarea>
					 </td>
					 <td width="10%">
						  <button id="comment_submit" type="submit" class="btn btn-outline-primary">작성</button>
					 </td>
				 </tr>
			 </table>
			 <input type="hidden" name="c_idx" id="c_idx" value="<%=c_idx%>">
			 <input type="hidden" name="comment_uniqueid" id="comment_uniqueid" value="<%=viewId%>">
		  </form>
		 <hr><hr>
<!-- 댓글 리스트 -->
	<div class="tblListComment">
		<table id="tblListComment" class="table table-bordered">
			<c:if test="${ clist.size() == 0 }">
				<tr>
					<td colspan="2">댓글이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach items="${ clist }" var="clist">
				<tr>
					<td>
						<c:if test="${clist.m_nickname == 'admin' }">
						<p><Strong>${ clist.comment_content }</Strong></p>
						</c:if>
						<c:if test="${clist.m_nickname != 'admin' }">
						${ clist.comment_content }
						</c:if>
						<c:if test="${ empty clist.m_nickname }">
						<span>${ clist.comment_nick }. ${ clist.reg_date }</span>
						</c:if>
						<c:if test="${ empty clist.comment_nick }">
						<span>${ clist.m_nickname }. ${ clist.reg_date }</span>
						</c:if>
					</td>
					<td>
						<c:if test="${m_uniqueID == clist.comment_uniqueid && m_nickname != 'admin'}">
						<input type="button" value="수정" class="btn btn-default" 
							onclick="openPopup('mod',${clist.comment_idx},'${clist.comment_content}')"/>
						<input type="button" value="삭제" class="btn btn-default" 
							onclick="openPopup('delete',${clist.comment_idx},'${clist.comment_content}')"/>
						</c:if>
						<c:if test="${m_nickname == 'admin' }">
						<input type="button" value="삭제" class="btn btn-default" 
							onclick="openPopup('adminDel',${clist.comment_idx},'${clist.comment_content}')"/>
						</c:if>
					</td>
				</tr>
				
			</c:forEach>	
		</table>
	</div>
	<hr><hr>
	</center>
	<script type="text/javascript">
		// 04/09 허상호 : 매개변수로 전달 받는 값에 따라 댓글 수정,삭제 또는 관리자계정으로 댓글삭제 구분하여 실행되는 함수
		function openPopup(request,commentIdx,modContent){
			var url = null;
			var left = (screen.width/2)-250; 
			var top = (screen.height/2)-250;
			var c_idx = $("#c_idx").val();
			if(request == 'mod'){
				url = "<%=contextPath%>/board/commentMod.jsp?commentIdx=" + commentIdx + "&modContent=" + modContent;
				window.open(url, '수정요청창', 'width=450, height=250, left='+left+', top='+top);
			}else if(request == 'delete'){
				url = "<%=contextPath%>/board/commentDel.jsp?commentIdx=" + commentIdx;
				window.open(url, '삭제요청창', 'width=450, height=200, left='+left+', top='+top);
			}else if(request == 'adminDel'){
				var adminDelPro = confirm("삭제하시겠습니까 ?");
				if(adminDelPro){
					location.href="<%=contextPath%>/comment/adminDelPro.bo?commentIdx=" + commentIdx + "&c_idx="+c_idx;
				}
			}
			
		}
	
	
		// 04/06 허상호 : 댓글 작성시 호출되는 함수
		$(document).ready(function() {
		  $('#comment_write').submit(function(event) {
		    event.preventDefault(); // 기본 동작 취소
		    
		    var nickname = $('#m_nickname').val();
		
		    if(nickname == null){
		    	 var comment_nick = $('#comment_nick').val();
		    } 
	       
    		var comment_pw = $('#comment_pw').val();
		    var comment_content = $('#comment_content').val();
		    var c_idx = $('#c_idx').val();
		    var comment_uniqueid = $('#comment_uniqueid').val();
				
		    $.ajax({
		    	type: "post",
				async : true,
				url : "<%=contextPath%>/comment/addComment.bo",
		     	data: {
	     		nickname : nickname,
		        comment_nick : comment_nick,
		        comment_pw: comment_pw,
		        comment_content : comment_content,
		        c_idx : c_idx,
		        comment_uniqueid : comment_uniqueid
		      },
		      dataType : "text",
		      success: function(response) {
		        $('#comment_pw').val("");
		        $('#comment_content').val("");
		        location.reload();
		      }
		    });
		  });
		}); 
		
		<!-- 목록버튼 클릭했을때 03/20 허상호 -->
		$("#list").click(function(event) {
			event.preventDefault();
			 console.log("Event object:", event);
			//community테이블에 저장된 글을 조회 하는 요청!
			location.href = "<%=contextPath%>/com/listByRecent.bo?nowPage=<%=nowPage%>&nowBlock=<%=nowBlock%>";
			
		})
		
			var check = "<%=check%>";
			if(check == "yes"){
				$("#like_btn").css({border : "red"});
				$("#likeimg").attr("src","<%=contextPath%>/eq/img/good2.png");
			}else{
				$("#like_btn").css({backgroundColor : "white"});
				$("#likeimg").attr("src","<%=contextPath%>/eq/img/good.png");
			}
			
			$("#like_btn").on("click", function() {
				if(check == "no") {
					$.ajax({
						type: "post",
						async : true,
						url : "<%= contextPath %>/com/like.bo",
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
						url : "<%= contextPath %>/com/likeCancel.bo",
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
			
			// 04/02 허상호 글 수정 삭제 요청시 구분 후 폼태그 액션값 변경시키는 함수
			function boardRequest(request){
				if(request == 'delete'){
					$("#updateForm").css("visibility","visible");
					document.updateForm.action = "<%=contextPath%>/com/delBoard.bo";
				}else if(request == 'adminDelete'){
					var adminDel = confirm("삭제하시겠습니까 ?");
					if(adminDel){
						location.href="<%=contextPath%>/com/adminDel.bo?c_idx=<%=c_idx%>";
					}
				}else{
					$("#updateForm").css("visibility","visible");
					document.updateForm.action = "<%=contextPath%>/com/modBoard.bo";
				}
			}
			
		</script>
	</body>
</html>