<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String contextPath = request.getContextPath(); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
//버튼과 모달창 요소 가져오기
var modal = document.getElementById("modal");
var btn = document.getElementById("open-modal");
var span = document.getElementsByClassName("close")[0];

// 모달 열기
btn.onclick = function() {
  modal.style.display = "block";
}

// 모달 닫기
span.onclick = function() {
  modal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
<style>
/* 모달 스타일 */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  max-width: 600px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

</style>
</head>
	<body>
		<button id="open-modal">모달 열기</button>

		<div id="modal" class="modal">
		  <div class="modal-content">
		    <span class="close">&times;</span>
		    <p>모달 내용</p>
		  </div>
		</div>
	
	</body>
</html>