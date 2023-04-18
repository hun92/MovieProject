<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String contextPath = request.getContextPath();
    
    %>
    <style>
    	
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
    	
    	*{margin: 0;padding: 0;box-sizing: border-box}
		ul>li{list-style: none}
		a{text-decoration: none;}
		.clearfix::after{content: "";display: block;clear: both;}
    	
    	#joinForm{width: 700px;margin: 0 auto;}
		ul.join_box{border: 1px solid #ddd;background-color: #fff;}
		.checkBox,.checkBox>ul{position: relative;}
		.checkBox>ul>li{float: left;}
		.checkBox>ul>li:first-child{width: 85%;padding: 15px;font-weight: 600;color: #888;}
		.checkBox>ul>li:nth-child(2){position: absolute;top: 50%;right: 30px;margin-top: -12px;}
		.checkBox textarea{width: 96%;height: 90px; margin: 0 2%;background-color: #f7f7f7;color: #888; border: none;}
		.footBtwrap{margin-top: 15px;}
		.footBtwrap>li{float: left;width: 50%;height: 60px;}
		.footBtwrap>li>button{display: block; width: 100%;height: 100%; font-size: 20px;text-align: center;line-height: 60px;}
		.fpmgBt1{background-color: #fff;color:#888}
		.fpmgBt2{background-color: lightsalmon;color: #fff}
    	
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
	<center>
		<div class="joinf">
		<a href="<%= contextPath%>/member1/main.me">
			<img src="<%=contextPath%>/eq/img/mm2.png" width="200px"><br>
			</a>
			<div class="ottdiv">
			<img src="<%=contextPath%>/eq/img/1231.png" width="600px">
			</div>
			<h2>약관 동의</h2>
			
			
			
			
			
			<form action="<%= contextPath%>/member1/join2.me" id="joinForm" onsubmit="return chk();">
           
            <ul class="join_box">
                <li class="checkBox check01">
                    <ul class="clearfix">
                        <li>이용약관, 개인정보 수집 및 이용,
                            위치정보 이용약관(선택), 프로모션 안내
                            메일 수신(선택)에 모두 동의합니다.</li>
                        <li class="checkAllBtn">
                        
                            <input type="checkbox" name="selectall" value="selectall" onclick="selectAll(this)" />
                            
                        </li>
                    </ul>
                </li>
                <li class="checkBox check02">
                    <ul class="clearfix">
                        <li>이용약관 동의(필수)</li>
                        <li class="checkBtn">
                        
                            <input type="checkbox" name="animal" id="animal1" value="chk1" onclick="checkSelectAll()"/> 
                            
                        </li>
                    </ul>
                    <textarea name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
                </li>
                <li class="checkBox check03">
                    <ul class="clearfix">
                        <li>개인정보 수집 및 이용에 대한 안내(필수)</li>
                        <li class="checkBtn">
                        
                            <input type="checkbox" name="animal" id="animal2" value="chk2" onclick="checkSelectAll()"/>
                            
                        </li>
                    </ul>
 
                    <textarea name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
                </li>
                <li class="checkBox check03">
                    <ul class="clearfix">
                        <li>위치정보 이용약관 동의(선택)</li>
                        <li class="checkBtn">
                        
                            <input type="checkbox" name="animal" id="animal3" value="chk3" onclick="checkSelectAll()"/>
                            
                            
                        </li>
                    </ul>
 
                    <textarea name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
      				</textarea>
                </li>
          
          
          
          <button type="submit">동의</button>
          
        </form>
			
		</div>
	</center>


<script>

function checkSelectAll()  {
	  // 전체 체크박스
	  const checkboxes 
	    = document.querySelectorAll("input[name='animal']");
	  // 선택된 체크박스
	  const checked 
	    = document.querySelectorAll("input[name='animal']:checked");
	  // select all 체크박스
	  const selectAll 
	    = document.querySelector("input[name='selectall']");
	  
	  if(checkboxes.length === checked.length)  {
	    selectAll.checked = true;
	  }else {
	    selectAll.checked = false;
	  }

	}

	function selectAll(selectAll)  {
	  const checkboxes 
	     = document.getElementsByName("animal");
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	  })
	}
	
	
function chk() {
	
	var animal1 = document.getElementById("animal1").checked;
	var animal2 = document.getElementById("animal2").checked;
	
	
	if(animal1 == "" || animal2 == ""){
		alert("필수동의 모두 선태해 주세요");
		return false;
	}
	
	return true;	
}
	
	
	
	
 

</script>

</body>
</html>