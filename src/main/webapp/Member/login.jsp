<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String contextPath = request.getContextPath();
	
	//네이버 로그인 관련 부분들
	String clientId = "Kf9C_RzsFYJraczQjC3Q";//애플리케이션 클라이언트 아이디값";
	String client_secret = "zUvJzqCB3f";
	String redirectURI = URLEncoder.encode("http://localhost:8090/greaitProject/member1/naverLoginAuth.me", "UTF-8");
	//리다이렉트 url은 애플리케이션에 등록된 리다이렉션 url과 정확히 일치해야 함 그렇지 않으면 오류 남.
	SecureRandom random = new SecureRandom();
	//state는 보안을 위해 만들어진 문자열
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	apiURL += "&client_id=" + clientId;
	apiURL += "&redirect_uri=" + redirectURI;
	apiURL += "&state=" + state;
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Login</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	<meta name="author" content="FREEHTML5.CO" />
	
	<link rel="stylesheet" href="<%=contextPath%>/css/style.css">
	
	<link rel="stylesheet" id="theme-switch" href="<%=contextPath%>/css/style.css">
	<link href="<%=contextPath %>/eq/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=contextPath %>/eq/css/sidebars.css" rel="stylesheet">
	
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<style>
		
		.logfa{
			text-align : center;
			width : 400px;
			margin : 200px 0;
			
		}
		
		.logfa button{
			background-color : gray;
			color : white;
			width : 50%;
			height: 40px;
			border-radius: 10px;
		}
		
		a{
			color : gray;
			text-decoration: none;
		}
		#easyLogin td{
			width : 60px;
		}
		.googleBtn{
			padding-left: 10px;
		}
		
	</style>
</head>
<center>
<body align="center">
	<div class="logfa">
		
		<a href="<%= contextPath%>/Crawling/maincenter.me">	
   		<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br><br>
   		</a>
   		
   		
   		<form class="form-signin" action="<%= contextPath%>/member1/loginPro.me" id="login" onsubmit="return login();" method="post">
   		
	   		<input id="m_id" class="loginp" type="text" name="m_id" placeholder="아이디"><br>
	   		<input id="m_pw" class="loginp" type="password" name="m_pw" placeholder="password"><br><br>
	   		<button type="submit" >로그인</button><br>
   		<br>
   		</form>
   			<a href="<%=contextPath%>/member1/join1.me">회원가입</a><br><br>
   			<a href="javascript:(0);" onclick="openPop('findID')">아이디 찾기</a> /
<%--    			<a href="<%=contextPath%>/member1/findID.me">아이디 찾기</a>   --%>
   			<a href="javascript:(0);" onclick="openPop('changePW')">비밀번호 변경</a>
<%--    			<a href="<%=contextPath%>/member1/changePW.me">비밀번호 변경</a> --%>
   			<br><br>		
   		
   		<table align="center" id="easyLogin">
   			<tr>
   				<td><a href="javascript:kakaoLogin()"><img src="<%=contextPath%>/eq/img/kakao_icon.png" width="40px" height="40px"></a></td>
   				<td><a href="#"><img onclick="naverlogin();" src="<%=contextPath%>/eq/img/naver_icon.png" width="40px" height="40px"></a></td>
   				<td class="googleBtn">
			   		<div id="g_id_onload"
					     data-client_id="172053655777-mjlei55v7co41ksjj9duc3vsi4p8qns8.apps.googleusercontent.com"
					     data-context="signin"
					     data-callback="handleCredentialResponse"
					     data-nonce=""
					     data-itp_support="true">
					</div>
					<div class="g_id_signin"
						  data-type="icon"
						  data-size="large"
						  data-theme="outline"
						  data-text="signin_with"
						  data-shape="circle"
						  data-logo_alignment="left">
					</div>
   				</td>
   			</tr>
   		</table>
	</div>
</center>

<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://accounts.google.com/gsi/client"></script>
<script type="text/javascript">

		function openPop(request){
			var url = null;
			var left = (screen.width/2)-250; 
			var top = (screen.height/2)-250;
			if(request == 'findID'){
				url = "<%=contextPath%>/member1/findID.me";
				window.open(url, '아이디 찾기', 'width=600, height=450, left='+left+', top='+top);
			}else if(request == 'changePW'){
				url = "<%=contextPath%>/member1/changePW.me";
				window.open(url, '비밀번호 변경', 'width=600, height=580, left='+left+', top='+top);
			}
		}
	

	//Kakao.init()함수는 카카오 api를 사용하기 위해 인증키를 초기화합니다.
	Kakao.init('1de5dcc9cb8ef52a2b543b50fde654cf');	
	function kakaoLogin() {
		//Kakao.Auth.login() 함수를 호출하여 사용자를 인증하고
        Kakao.Auth.login({
        	//인증 성공시
            success: function(response) {
            	//Kakao.API.request() 함수를 호출하여 사용자 정보를 가져옵니다.
                Kakao.API.request({
                	//현재 로그인 한 사용자의 정보를 가져오는 api 엔드포인트 주소이다.
                    url: '/v2/user/me',
                    success: function (response) {
                    	//이후, 가져온 사용자 정보를 JSON.stringify()함수를 사용하여 문자열 형태로 변환하고 alert를 이용하여 출력합니다.
//                     	alert(JSON.stringify(response))
                    	$.ajax({
                    		type: "post",
                    		async: true,
                    		url: "<%=contextPath%>/member1/kakaoLoginPro.me",
                    		data:{ 	
                    			name : response.properties.nickname,
                    			uniqueID : response.id,
                    			email : response.kakao_account.email
                    			},
                    		dataType: "text",
                    		success: function(data) {
                    			if(data == "1") {
                    				location.href="<%= contextPath %>/Crawling/maincenter.me";
                    			} else {
                    				alert("로그인에 실패했습니다.");
                    			}
                    		}
                    	});
                    },
                    fail: function (error) {
                        alert(JSON.stringify(error))
                    },
                });
            },
            fail: function (error) {
                alert(JSON.stringify(error))
            },
        });
    }
	
	
	
		function login() {
			var m_id = document.getElementById("m_id").val();
			var m_pw = document.getElementById("m_pw").val();
		
			
			if(m_id == "" || m_pw == ""){
				alert("아이디와 비밀번호를 모두 입력해 주세요");
				return false;
			}
			
			return true;
		}
		
		
		function naverlogin() {
			location.href="<%= apiURL %>";
		}
		
		//구글 로그인 시작
		function handleCredentialResponse(response) {
			if (response.credential) {
				// 로그인에 성공한 경우 로직 작성
				console.log(response.credential);
				$.ajax({
					type: "get",
					async: true,
					url: "<%= contextPath %>/member1/googleLogin.me",
					data: { token : response.credential },
					dataType: "text",
					success: (data) => {
						if(data == "1") {
							location.href="<%= contextPath %>/Crawling/maincenter.me";
						} else {
							alert("로그인에 실패했습니다.");
						}
					}
				})
				
			} else {
				// 로그인에 실패한 경우 로직 작성
				console.log("로그인 실패");
			}
		}
		
		function instagramlogin() {
			$("#login").submit();
		}

	</script>
	
</body>
</html>
