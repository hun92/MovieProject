<%@page import="VO.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <%
   
    request.setCharacterEncoding("UTF-8");
	
   	String contextPath = request.getContextPath();
   
	String loginNick = (String)session.getAttribute("m_nickname");
	
   %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

 <meta name="viewport" content="width=device-width, initial-scale=1">

 <link rel="stylesheet" href="<%= contextPath%>/Chat/css/bootstrap.css">
 <link rel="stylesheet" href="<%= contextPath%>/Chat/css/custom.css">

<title>실시간 채팅</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

 <script src="<%= contextPath%>/Chat/js/bootstrap.js"></script>

	<script type="text/javascript">
		
	
		// 마지막으로 불러온 채팅의 ID를 저장할 변수
		var lastID = 0;
		
		// 채팅 전송 버튼 클릭 이벤트 핸들러
		function submitFunction() {
			
			// 입력된 닉네임과 채팅 내용 가져오기
			var m_nickname = $('#m_nickname').val();
			var chatContent = $('#chatContent').val();
			
			// 입력된 닉네임과 채팅 내용이 빈 공백인 경우 함수 종료
			if(m_nickname.trim() === '' || chatContent.trim() === ''){
				
				// 닉네임과 내용을 모두 입력해주세요. 메시지를 보여줌
		        autoClosingAlert('#dangerMessage', 2000);
				
				return;
			}
			
			// ChatSubmitServlet에 입력된 데이터 전송
			$.ajax({
				type: "POST",
				url: "<%=contextPath%>/ChatSubmitServlet",
				data: {
					m_nickname: encodeURIComponent(m_nickname),
					chatContent: encodeURIComponent(chatContent)
				},
				
				// 데이터 전송 성공 시 채팅 리스트 갱신
				success: function(result) {
					if(result == 1) {
						autoClosingAlert('#successMessage', 2000);
					}else if(result == 0){
						autoClosingAlert('#dangerMessage', 2000);
					}else {
						autoClosingAlert('#warningMessage', 2000);

					}
					
					chatListFunction('today');
					 $('#chatList').empty();
					
				}
				
			});

			// 채팅 입력 창 비우기
			$('#chatContent').val('');
		}
		
		// 자동 닫히는 알림 메시지 함수
		function autoClosingAlert(selector, delay) {
		    var alert = $(selector);
		    alert.show();
		    window.setTimeout(function() {alert.hide()}, delay);
		}
		
		
		// 채팅 리스트 불러오는 함수
		function chatListFunction(type) {
			
		console.log(type);
			
			// ChatListServlet에 리스트 타입 전송하여 데이터 가져오기
			$.ajax({
				type: "POST",
				url: "<%=contextPath%>/ChatListServlet",
				data: {
					listType: type 
				},
				dataType: "text", // 추가
				
				// 데이터 가져오기 성공 시 각 채팅 내용을 화면에 추가
				success: function(data) {
					
					if(data == "") return;
					// JSON 형식으로 파싱하여 채팅 내용 추출	
					//String을 아래와 같이 JSONObject객체로 변경 
					var parsed = JSON.parse(data); //
					
					var result = parsed.result;

					
					// 각 채팅 내용을 addChat() 함수를 사용하여 화면에 추가
					for(var i = 0; i < result.length; i++) {
						
						 addChat(result[i][0].value, result[i][1].value, result[i][2].value);
					
					}
					
					// 마지막으로 불러온 채팅의 ID를 업데이트
					lastID = Number(parsed.last);
					
					
				},
				
				// 데이터 가져오기 실패 시 콘솔에 에러 출력
				error: function(xhr, status, error) {
		            console.log("Error: " + error);
				}
		        
			});
		}
		
		
		// 각 채팅 내용을 화면에 추가하는 함수
		function addChat(m_nickname, chatContent, chatTime) {
			if ($('#chatList').find('#chat_' + chatTime).length === 0) {
			$('#chatList').append('<div class="row">' +
								 '<div class="col-lg-12">' + 
								 '<div class="media">' +
								 '<a class="pull-left" href="#">'+
 								 
 								'<img class="media-object img-circle" src="<%=contextPath%>/Chat/images/mood.jpg" alt="Profile Image">'+
								 
 								'</a>'+
								 '<div class="media-body">' +
								 '<h4 class="media-heading">' +
								 m_nickname +
								 '<span class="small pull-right">' +
								 chatTime +
								 '</span>' +
								 '</h4>' +
								 '<p>' +
								 chatContent +
								 '</p>' +
								 '</div>' +
								 '</div>' +
								 '</div>' +
								 '</div>' +
								 '<hr>');
								$('#chatList').scrollTop($("#chatList")[0].scrollHeight);	 
							}
						}

		
		function getInfiniteChat() {
		setInterval(function() {
		chatListFunction(lastID);
			}, 1000);
								
			}
		
		$(document).ready(function() {
				chatListFunction('today'); // chatListFunction 호출하여 type에 'ten'을 전달
				getInfiniteChat();
			
			});
		
	</script>


</head>
<body>

	<div>
		<div class=" bootstrap snippet">
			<div class="row">
				<div class="col-xs-12">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4><i class="fa fa-circle text-green"></i>실시간 채팅창</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 450px; ">
							</div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<% if(loginNick != null){ //로그인 했을경우%>
										<input style="height: 40px;" type="text" id="m_nickname" class="form-control" value="<%=loginNick%>" maxlength="8" readonly>
										<%}else{ //로그인 하지 않았을경우 %>
										<input style="height: 40px;" type="text" id="m_nickname" class="form-control" placeholder="이름" maxlength="8">
										<%} %>
									</div>
								</div>
								<div class="row" style="height:90px;">
									<div class="form-group col-xs-10">
										<textarea style="height:80px;" id="chatContent" class="form-control" placeholder="메시지를 입력해주세요." maxlength="100" onkeydown="if(event.keyCode==13){submitFunction(); return false;}"></textarea>
										
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
										<div class="clearfix"></div>
									</div>	
								</div>
							</div>		
						</div>
					</div>
				</div>
			</div>
		</div>	
		
		<div class="alert alert-success" id="successMessage" style="display:none;">
			<strong>메세지 전송에 성공했습니다.</strong>
		</div>
		
		<div class="alert alert-danger" id="dangerMessage" style="display:none;">
			<strong>닉네임과 내용을 모두 입력해주세요.</strong>
		</div>
		
		<div class="alert alert-warning" id="warningMessage" style="display:none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>								

</body>
</html>