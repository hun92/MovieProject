<%@page import="VO.MemberVO"%>
<%@page import="DAO.MemberDAO"%>
<%@page import="VO.CommunityVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page
language="java" 
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	String nickname = (String)session.getAttribute("m_nickname");
	boolean wc = (boolean)session.getAttribute("checkWeekend");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Sunflower:wght@300&display=swap" rel="stylesheet">
					
		
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
		let wc = "<%= wc %>";
		if(wc == "true") {
// 			alert("오늘은 주말입니다.");
		} else {
// 			alert("오늘은 주말이 아닙니다.");
		}
		
		function fnSearch(){
			var word = document.getElementById("word").value;
			if(word == null || word == ""){
				alert("검색어를 입력하세요."); 
				document.getElementById("word").focus();
				return false;
			}
			else{
				document.frmSearch.submit();
			}
		}
		
		function fnRead(val){
			document.frmRead.action = "<%=contextPath%>/com/read.bo";
			document.frmRead.c_idx.value = val;
			document.frmRead.submit();
		}
		
		function noticeRead(val){
			document.frmRead.action = "<%=contextPath%>/com/noticeRead.bo";
			document.frmRead.c_idx.value = val;
			document.frmRead.submit();
		}
		
		function goMypage(uniqueID) {
			document.mypage.userUniqueID.value = uniqueID;
			document.mypage.submit();
		}
		
		</script>
		<style>
			.listtext{
				width : 97%;
			}
			
			.listtext2{
				width : 97%;
				height: 800px;
			}
		
			a{
				color: black;
				text-decoration: none;
			}
			
			.listbtn{
				width: 50%;
				height: 40px;
			}
			.listbtn2{
				width: 100%;
				height: 40px;
				text-align: center;
			}
			.listbtn2 td{
				width: 25%;
			}
			.listbtn2 button{
				border: none;
				width: 99%;
				height: 40px;
				background-color: white;
				border-bottom: 2px solid black;
				font-size: 1.4em;
				transition: all 0.1s linear;
				font-family: 'Do Hyeon', sans-serif;
			}
			
			.listbtn2 button:hover {
				border-bottom: 2px solid red;
			}
			
			.selecttr:hover{
				background-color: #F5A9BC;
			}
			
			.textselect:hover{
				background-color: #E6E6E6;
			}
			
		</style>
		
		
		
		
		
	</head>
<body>
	
<%
int totalRecord = 0; //board테이블에 저장된 글의 총개수 -
int numPerPage = 20; //한 페이지당 조회해서 보여줄 글 개수  -
int pagePerBlock = 4; //한 블럭당 묶여질 페이지 번호 개수 -
 					  //  1  2  3  4 <- 한블럭으로 묶음

int totalPage = 0; //총 페이지수 - 
int totalBlock = 0; // 총 블럭수 -
int nowPage = 0; //현재 사용자에게 보여지고 있는 페이지가 위치한 번호 저장  -
				 //(클릭한 페이지 번호 구하여 저장)
int nowBlock = 0;//클릭한 페이지 번호가 속한~~~~~ 블럭위치번호값 저장 -
int beginPerPage = 0; //각 페이지마다 ~~ 보여지는 시작 글번호(맨위의 글번호)저장 -

//BoardController에서 재요청해서 전달한 request에 담긴 ArrayList배열 꺼내오기 
//조회된 글들 
ArrayList list = (ArrayList)request.getAttribute("list");
ArrayList noticeList = (ArrayList)request.getAttribute("noticeList");

//조회된 총 글 개수 
totalRecord = (Integer)request.getAttribute("count");
int totalNoticeRecord = (Integer)request.getAttribute("noticeCount");
if(totalNoticeRecord > 4) {
	totalNoticeRecord = 4;
}

//현재 페이지 번호를 클릭했다면?
if( request.getAttribute("nowPage") != null){
	nowPage = Integer.parseInt(
								request.getAttribute("nowPage")
								.toString() 
							   );	
}

//각 페이지 번호에 보여지는 글목록의 가장위의 글에대한 글번호 구하기
beginPerPage = nowPage * numPerPage;

totalPage =  (int)Math.ceil( (double)totalRecord / numPerPage );      

//클릭한 페이지번호가 속한 블럭위치번호 구하기
if(request.getAttribute("nowBlock") != null){
	
	//BoardController로 부터 전달 받는다.
	nowBlock = Integer.parseInt(
								request
								.getAttribute("nowBlock")
								.toString()
								);	
}
	
//총 블럭수 구하기 
//총 블럭수  = 총 페이지수  / 한블럭당 묶여질 페이지 개수 
totalBlock = (int)Math.ceil( (double)totalPage / pagePerBlock ); 

%>
<center>
<form name="frmRead">
		<input type="hidden" name="c_idx">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="nowBlock" value="<%=nowBlock%>">
</form>

<table class="listtext">
	<tr height="40"> 
		<td style="text-align: center;"> 
			<img alt="게시판" src="<%=contextPath%>/eq/img/banner/boardbanner.jpg" width="98%">
		</td>
	</tr>
	<tr> 
		<td colspan="3">
			<div align="center">
			<hr border="2px solid gray">
			</div>
		</td>
	</tr>
</table>
<div class="listbtn">
	<table class="listbtn2">
	<tr><td>
	<button onclick="javascript:location.href='<%= contextPath %>/com/bestPost.bo?nowPage=0&nowBlock=0'">개념글</button>&nbsp;
	</td><td>
	<button onclick="javascript:location.href='<%= contextPath %>/com/listByLike.bo?nowPage=0&nowBlock=0'">좋아요순</button>&nbsp;
	</td><td>
	<button onclick="javascript:location.href='<%= contextPath %>/com/listByViews.bo?nowPage=0&nowBlock=0'">조회수순</button>&nbsp;
	</td><td>
	<button onclick="javascript:location.href='<%= contextPath %>/com/listByRecent.bo?nowPage=0&nowBlock=0'">최신순</button>&nbsp;
	</td></tr>
	</table> 	
</div>

<table class="listtext2">	
	<tr> 
		<td colspan="3" valign="top">
			<div align="center"> 
	    	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	        	<tr> 
	        		<td colspan="4" style="height: 19px">&nbsp;</td> 
	        	</tr>
	        	
	        	<tr> 
	        		<td colspan="4">
						<table border="0" width="100%" cellpadding="2" cellspacing="0">
							<tr align="center" bgcolor="#D0D0D0" height="40px" style="border-bottom: 2px solid black;">
								<td align="left" width="10%"><b>번호</b></td>
								<td align="left" width="40%"><b>제목</b></td>
								<td align="left" width="20%"><b>작성자</b></td>
								<td align="left" width="15%"><b>작성일</b></td>
								<td align="left" width="7.5%"><b>조회수</b></td>
								<td align="left" width="7.5%"><b>추천</b></td>
							</tr>
				<%
					//게시판 board테이블에서 조회된 글이 없다면?
					if(list.isEmpty()){
				%>		
							<tr align="center">
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
				<%		
					}else{//게시판 board테이블에서 조회된 글들이 있다면?
						if(!noticeList.isEmpty()) {
							for(int i=0; i<totalNoticeRecord; i++){
								CommunityVO vo = (CommunityVO)noticeList.get(i);
								
								String content = vo.getC_content();
								if(content.length() > 20) {
									content = content.substring(0, 20) + "...";
								}
				%>
								<tr align="center" bgcolor="#F8E0E6" height="40px" class="selecttr">
									<td align="left"><%=vo.getC_idx()%></td>
									<td align="left">
								<%
									int width = 0;  //답변글에 대한 이미지의 들여쓰기 너비값
									//글의 들여쓰기정도 level값이 0보다 크다면?답변글
									if(vo.getC_level() > 0){
										width = vo.getC_level() * 10;
								%>
									<img src="<%=contextPath%>/board/images/level.gif" width="<%=width%>" height="15">
									<img src="<%=contextPath%>/board/images/re.png" width="50" height="30">
								<%	
									}
								%>		
									<%--글제목 나타내는 곳 --%>
									<a href="javascript:noticeRead('<%=vo.getC_idx()%>')">
										<b>[공지사항]&nbsp;<%=vo.getC_title()%> </b>
									</a>
								</td>
								
								<td align="left">
									<img width="20%" alt="프로필 사진" src="<%= contextPath %>/Member/images/admin.png">
									<%=vo.getC_nickname()%>
								</td>
								<td align="left"><%=vo.getC_date()%></td>
								<td align="left"><%=vo.getC_views()%></td>
								<td align="left"><%=vo.getC_like()%></td>
								</tr>
				<%				
							}
						}
							
						//게시판----------------------------------------------------------------------------	
						for(int i=beginPerPage; i<(beginPerPage+numPerPage); i++){
							
							//만약 각페이지마다 보여지는 시작글번호가  게시판의 총글의 개수와 같으면 
							if(i == totalRecord){
								break;
							}
							
								CommunityVO vo = (CommunityVO)list.get(i);
								
								MemberDAO memdao = new MemberDAO();
								MemberVO memvo = memdao.getMemVOByUniqueID(vo.getC_uniqueid());
								
								
								String content = vo.getC_content();
								if(content.length() > 20) {
									content = content.substring(0, 20) + "...";
								}
				%>			
								
							<tr height="40px" class="textselect">
								<td align="left"><%=vo.getC_idx()%></td>				
								<td>
								<%
// 								    int level = vo.getB_level();
																		
// 									for(int j=0; j<level*4; j++){
// 										out.print("&nbsp;");
// 									}
								
									int width = 0;  //답변글에 대한 이미지의 들여쓰기 너비값
									
									//글의 들여쓰기정도 level값이 0보다 크다면?답변글
									if(vo.getC_level() > 0){
										
										width = vo.getC_level() * 10;
								%>
									<img src="<%=contextPath%>/board/images/level.gif" width="<%=width%>" height="15">
									<img src="<%=contextPath%>/board/images/re.png" width="50px" height="30px"> 
								<%	
									}
								%>		 
									<%--글제목 나타내는 곳 --%>
									<a href="javascript:fnRead('<%=vo.getC_idx()%>')">
										<%=vo.getC_title()%>
									</a>
								</td>
								<!-- 비회원 게시글일 때 -->
								<c:if test="<%= memvo == null %>">
									<td align="left"><%=vo.getC_nickname()%></td>
								</c:if>
								<!-- 회원 게시글일 때 -->
								<c:if test="<%= memvo != null %>">
									<td align="left"><img width="20%" alt="등급 이미지" src="<%= contextPath %>/Member/images/<%= memvo.getM_gradeimage() %>">
										<a href="#" onclick="goMypage('<%= vo.getC_uniqueid() %>');">
										LV. <%= memvo.getM_level() %> <%=vo.getC_nickname()%>
										</a>
									</td>
								</c:if>
								<td align="left"><%=vo.getC_date()%></td>
								<td align="left"><%=vo.getC_views()%></td>
								<td align="left"><%=vo.getC_like()%></td>
							</tr>
				<% 
						}//for		
					}
				%>				

						</table>
	        		</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
				<tr>

					<form action="<%=contextPath%>/com/searchlist.bo" 
						  method="post" 
						  name="frmSearch" 
						  onsubmit="javascript:fnSearch();">
		            	<td colspan="2">
		            		<div align="right"> 
			            		<select name="key">
			              			<option value="titleContent">제목 + 내용</option>
			              			<option value="name">작성자</option>
			              		</select>
			              	</div>
		              	</td>
			            <td width="26%">
			            	<div align="center"> &nbsp;
			            		<input type="text" name="word" id="word"/>
			            		<input type="submit" value="검색"/>
			            	</div>
			            </td>
		            </form>      
	            	<%-- 새글쓰기 버튼이미지 --%>
		            <td width="38%" style="text-align: left"> 
		             	<input type="image" 
		             		   src="<%=contextPath%>/eq/img/newwrite.png" width="100px"
		             		   onclick="location.href='<%=contextPath%>/com/write.bo?nowBlock=<%=nowBlock%>&nowPage=<%=nowPage%>'"/>
		        	</td>
		        </tr>
	       		<tr>
	       			<td colspan="4">&nbsp;</td>
	       		</tr>
			</table>
			</div>
	 	</td>
	</tr>
	<tr align="center"> 
		<td  colspan="3" align="center">
		Go To Page
		<%   
			if(totalRecord != 0){//DB에 글이 있다면?
					
				if(nowBlock > 0){//현재 클릭한 페이지번호가 속한 블럭위치가 0 보다 크다면?
		%>			
					<a href="<%=contextPath%>/com/listByRecent.bo?nowBlock=<%=nowBlock-1%>&nowPage=<%=((nowBlock-1) * pagePerBlock)%>">
						◀ 이전<%=pagePerBlock%>개
					</a>
		<%		}//안쪽 if %>
			
				
		<%
				for(int i=0; i<pagePerBlock; i++){
		%>			
					&nbsp;&nbsp;
					<a href="<%=contextPath%>/com/listByRecent.bo?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock * pagePerBlock)+i%>">
						<%=(nowBlock * pagePerBlock)+i+1 %>	
						<%if((nowBlock * pagePerBlock)+i+1 == totalPage) break; %>
					</a>
					&nbsp;&nbsp;
		<%			
				}
		%>		
			   
			 
		<%
				if(totalBlock > nowBlock + 1){
		%>			
					
					<a href="<%=contextPath%>/com/listByRecent.bo?nowBlock=<%=nowBlock+1%>&nowPage=<%=((nowBlock+1) * pagePerBlock)%>">
						  ▶ 다음 <%=pagePerBlock%>개
					</a>
				
		<%			
				}
		%>	   
			   	
				
				
		<% }//바깥 if %>
		
		
		</td> 
	</tr>
</table>
</center>
<form action="<%= contextPath %>/member1/mypage.me" method="post" name="mypage">
	<input type="hidden" name="userUniqueID">
</form>
</body>
</html>