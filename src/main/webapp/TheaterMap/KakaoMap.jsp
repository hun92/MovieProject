<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String contextPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
	<head>
	<!-- 한성준 03-16 카카오맵 지도 -->
  <meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.108.0">
    <title>극장지도</title>
    
    
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/map.css">
 	<link rel="stylesheet" href="<%=contextPath%>/eq/js/jquery.bxslider.min.css">
	<link href="<%=contextPath %>/eq/css/sidebars.css" rel="stylesheet">
	<link rel="stylesheet" href="<%=contextPath%>/eq/css/myCss.css">
	
	
	</head>
		<!-- 부트스트랩 이용을 위한 jQuery와 CDN -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<body>
	<center>
	<br>
		<div>
			<img alt="지도찾기" src="<%=contextPath%>/eq/img/banner/moviemapbanner.jpg" width="98%">
			
			<hr>
		
		<div class="map_wrap">
		    <div id="map" style="width:80%;height:500px;position:relative;overflow:hidden;"></div>	
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		                <form onsubmit="searchPlaces(); return false;">
		                    키워드 : <select value=" " id="key1">
		                    		<optgroup label="특별자치시">
		                    			<option value="세종">세종</option>
		                    		</optgroup>
		                    		<optgroup label="서울특별시">
		                    			<option value="서울">서울</option>
		                    		</optgroup>
		                    		<optgroup label="광역시">
		                    			<option value="광주">광주</option>
		                    			<option value="대구">대구</option>
		                    			<option value="인천">인천</option>
	                    				<option value="부산">부산</option>
	                    				<option value="대전">대전</option>
	                    				<option value="울산">울산</option>
	                    			</optgroup>
	                    			<optgroup label="경기도">
	                    				<option value="광주">광주</option>
	                    				<option value="고양">고양</option>
	                    				<option value="광명">광명</option>
	                    				<option value="구리">구리</option>
	                    				<option value="군포">군포</option>
	                    				<option value="김포">김포</option>
	                    				<option value="남양주">남양주</option>
	                    				<option value="동두천">동두천</option>
	                    				<option value="부천">부천</option>
	                    				<option value="성남">성남</option>
	                    				<option value="수원">수원</option>
	                    				<option value="시흥">시흥</option>
	                    				<option value="안산">안산</option>
	                    				<option value="안성">안성</option>
	                    				<option value="안양">안양</option>
	                    				<option value="양주">양주</option>
	                    				<option value="여주">여주</option>
	                    				<option value="오산">오산</option>
	                    				<option value="의왕">의왕</option>
	                    				<option value="의정부">의정부</option>
	                    				<option value="이천">이천</option>
	                    				<option value="파주">파주</option>
	                    				<option value="평택">평택</option>
	                    				<option value="포천">포천</option>
	                    				<option value="하남">하남</option>
	                    				<option value="화성">화성</option>
	                    			</optgroup>
	                    			<optgroup label="강원도">
	                    				<option value="강릉">강릉</option>
	                    				<option value="동해">동해</option>
	                    				<option value="삼척">삼척</option>
	                    				<option value="속초">속초</option>
	                    				<option value="원주">원주</option>
	                    				<option value="춘천">춘천</option>
	                    				<option value="태백">태백</option>
	                    			</optgroup>
	                    			<optgroup label="충청북도">
	                    				<option value="제천">제천</option>
	                    				<option value="청주">청주</option>
	                    				<option value="충주">충주</option>
	                    			</optgroup>
	                    			<optgroup label="충청남도">
	                    				<option value="계룡">계룡</option>
	                    				<option value="공주">공주</option>
	                    				<option value="논산">논산</option>
	                    				<option value="당진">당진</option>
	                    				<option value="보령">보령</option>
	                    				<option value="서산">서산</option>
	                    				<option value="아산">아산</option>
	                    				<option value="천안">천안</option>
	                    			</optgroup>
	                    			<optgroup label="경상북도">
			                    		<option value="경산">경산</option>
		                    			<option value="경주">경주</option>
		                    			<option value="구미">구미</option>
		                    			<option value="김천">김천</option>
		                    			<option value="문경">문경</option>
		                    			<option value="상주">상주</option>
		                    			<option value="안동">안동</option>
		                    			<option value="영주">영주</option>
		                    			<option value="영천">영천</option>
		                    			<option value="포항">포항</option>
		                    		</optgroup>
	                    			<optgroup label="경상남도">
			                    		<option value="양산" selected>양산</option>
		                    			<option value="거제">거제</option>
		                    			<option value="김해">김해</option>
		                    			<option value="밀양">밀양</option>
		                    			<option value="사천">사천</option>
		                    			<option value="진주">진주</option>
		                    			<option value="창원">창원</option>
		                    			<option value="통영">통영</option>
		                    		</optgroup>
		                    		<optgroup label="전라북도">
			                    		<option value="군산">군산</option>
		                    			<option value="김제">김제</option>
		                    			<option value="남원">남원</option>
		                    			<option value="익산">익산</option>
		                    			<option value="진주">진주</option>
		                    			<option value="정읍">정읍</option>
		                    		</optgroup>
		                    		<optgroup label="전라남도">
			                    		<option value="광양">광양</option>
		                    			<option value="나주">나주</option>
		                    			<option value="목포">목포</option>
		                    			<option value="순천">순천</option>
		                    			<option value="여수">여수</option>
		                    		</optgroup>
	                    			<optgroup label="제주특별자치도">
	                    				<option value="제주">제주</option>
	                    				<option value="서귀포">서귀포</option>
	                    			</optgroup>
		                    	   </select><br>
		                    검색 : <input type="text" value="메가박스" id="key2" size="15"><br>
		                    <button type="submit">검색하기</button> 
		                </form>
		            </div>
		        </div>
		        <hr>
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>
		    </div>
		</div><br><br>
		</div>
        <!-- 부트스트랩 primary 버튼 -->
		<button type="button" class="btn btn-lg btn-outline-secondary" onclick="getCurrentPosBtn()">내 위치 가져오기</button>
		<br><br>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03ee57845e2ad12c56c633932350ce12&libraries=services"></script>
		<script>
			// 마커를 담을 배열입니다
			var markers = [];
			let presentPosition;
	
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.56646, 126.98121), // 지도의 중심좌표
			        level: 3, // 지도의 확대 레벨
// 			        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
			    }; 
			
			// 지도를 생성한다 
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		    if (navigator.geolocation) {
		        
		        // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		        navigator.geolocation.getCurrentPosition(function(position) {
		            
		            var lat = position.coords.latitude, // 위도
		                lon = position.coords.longitude; // 경도
		            
		            var locPosition = new kakao.maps.LatLng(lat, lon) // geolocation으로 얻어온 좌표
		            presentPosition=locPosition;
		     
		            map.setCenter(locPosition);   
		                
		          });
		        
		    } else { // HTML5의 GeoLocation을 사용할 수 없을때 
		        
		        var locPosition = new kakao.maps.LatLng(37.566826, 126.9786567)
		        alert('현재 위치를 찾을 수 없습니다!');
		    }
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();  
			
			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			// 키워드로 장소를 검색합니다
			searchPlaces();
			
			// 키워드 검색을 요청하는 함수입니다
			function searchPlaces() {
			
			    var key1 = document.getElementById('key1').value;
				var key2 = document.getElementById('key2').value;
			    
				var keyword = key1+ key2;
				
			    if (!key2.replace(/^\s+|\s+$/g, '')) {
			        alert('키워드를 입력해주세요!');
			        return false;
			    }
			
			    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			    ps.keywordSearch( keyword, placesSearchCB); 
			}
			
			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
			
			        // 정상적으로 검색이 완료됐으면
			        // 검색 목록과 마커를 표출합니다
			        displayPlaces(data);
			
			        // 페이지 번호를 표출합니다
			        displayPagination(pagination);
			
			    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
			
			        alert('검색 결과가 존재하지 않습니다.');
			        return;
			
			    } else if (status === kakao.maps.services.Status.ERROR) {
			
			        alert('검색 결과 중 오류가 발생했습니다.');
			        return;
			
			    }
			}
			
			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {
			
			    var listEl = document.getElementById('placesList'), 
			    menuEl = document.getElementById('menu_wrap'),
			    fragment = document.createDocumentFragment(), 
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
			    
			    // 검색 결과 목록에 추가된 항목들을 제거합니다
			    removeAllChildNods(listEl);
			
			    // 지도에 표시되고 있는 마커를 제거합니다
			    removeMarker();
			    
			    for ( var i=0; i<places.length; i++ ) {
					
			    	const lon = places[i].x;
		            const lat = places[i].y;
			    	
			        // 마커를 생성하고 지도에 표시합니다
			        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			            marker = addMarker(placePosition, i), 
			            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
			
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        bounds.extend(placePosition);
					
			     	// 마커와 검색결과 항목에 mouseover 했을때
			        // 해당 장소에 인포윈도우에 장소명을 표시합니다
			        // mouseout 했을 때는 인포윈도우를 닫습니다
			        (function(marker, title) {
			        	kakao.maps.event.addListener(marker, 'mouseover', function() {
		                    displayInfowindow(marker, title);
		                });
		     
		                kakao.maps.event.addListener(marker, 'mouseout', function() {
		                    infowindow.close();
		                });
			        	
// 			        	kakao.maps.event.addListener(marker, 'click', function() {
// 				            displayInfowindow(marker, title)
// 				        });
			
			            itemEl.onmouseover =  function () {
			                displayInfowindow(marker, title);
			            };
			
			            itemEl.onmouseout =  function () {
			                infowindow.close();
			            };
			        })(marker, places[i].place_name);
			
			        fragment.appendChild(itemEl);
			        
			        // 마커와 검색 결과를 클릭했을때 좌표를 가져온다
		            (function(marker, title) {
		                kakao.maps.event.addListener(marker, 'click', function() {
		                    searchDetailAddrFromCoords(presentPosition, function(result, status) {
		                        if (status === kakao.maps.services.Status.OK) {
		                            detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
// 		                            location.href = "https://map.kakao.com/?sName="+detailAddr+"&eName="+title
		                            window.open("https://map.kakao.com/?sName="+detailAddr+"&eName="+title,"_blank");
		                        }
		                    });
		                })
		     
	                itemEl.onclick =  function () {
	                    searchDetailAddrFromCoords(presentPosition, function(result, status) {
	                        if (status === kakao.maps.services.Status.OK) {
	                            detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
// 	                            location.href = "https://map.kakao.com/?sName="+detailAddr+"&eName="+title
	                            window.open("https://map.kakao.com/?sName="+detailAddr+"&eName="+title,"_blank");
	                      	  }   
		                   });
		                };
		            })(marker, places[i].place_name);
		     
		            fragment.appendChild(itemEl);
			    }
			
			    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			    listEl.appendChild(fragment);
			    menuEl.scrollTop = 0;
			
			    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			    map.setBounds(bounds);
			}
			
			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {
			
			    var el = document.createElement('li'),
			    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
			                '<div class="info">' +
			                '   <h5>' + places.place_name + '</h5>';
			
			    if (places.road_address_name) {
			        itemStr += '    <span>' + places.road_address_name + '</span>' +
			                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
			    } else {
			        itemStr += '    <span>' +  places.address_name  + '</span>'; 
			    }
			                 
			      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
			                '</div>';           
			
			    el.innerHTML = itemStr;
			    el.className = 'item';
			
			    return el;
			}
			
			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
			    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
			        imgOptions =  {
			            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			        },
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
			            marker = new kakao.maps.Marker({
			            position: position, // 마커의 위치
			            image: markerImage
			        });
				
			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
			
			    return marker;
			}
			
			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
			    for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}
			
			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
			    var paginationEl = document.getElementById('pagination'),
			        fragment = document.createDocumentFragment(),
			        i; 
			
			    // 기존에 추가된 페이지번호를 삭제합니다
			    while (paginationEl.hasChildNodes()) {
			        paginationEl.removeChild (paginationEl.lastChild);
			    }
			
			    for (i=1; i<=pagination.last; i++) {
			        var el = document.createElement('a');
			        el.href = "#";
			        el.innerHTML = i;
			
			        if (i===pagination.current) {
			            el.className = 'on';
			        } else {
			            el.onclick = (function(i) {
			                return function() {
			                    pagination.gotoPage(i);
			                }
			            })(i);
			        }
			
			        fragment.appendChild(el);
			    }
			    paginationEl.appendChild(fragment);
			}
			
			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
			    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>'
			    			
			    infowindow.setContent(content);
			    infowindow.open(map, marker);
//			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
			}
			
			 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {   
			    while (el.hasChildNodes()) {
			        el.removeChild (el.lastChild);
			    }
			}
			
			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
			function locationLoadSuccess(pos){
			    // 현재 위치 받아오기
			    var currentPos = new kakao.maps.LatLng(pos.coords.latitude,pos.coords.longitude);

			    // 지도 이동(기존 위치와 가깝다면 부드럽게 이동)
			    map.panTo(currentPos);
			    
			    /* // 마커 생성
			    var marker = new kakao.maps.Marker({
			        position: currentPos
			    });

			    // 기존에 마커가 있다면 제거
			    marker.setMap(null);
			    marker.setMap(map); */
			};

			function locationLoadError(pos){
			    alert('위치 정보를 가져오는데 실패했습니다.');
			};

			// 위치 가져오기 버튼 클릭시
			function getCurrentPosBtn(){
			    navigator.geolocation.getCurrentPosition(locationLoadSuccess,locationLoadError);
			    
				//지도 레벨을 2으로 한뒤, 애니메이션 효과 옵션 설정
			    map.setLevel(2, {animate: true});
			};
			 // 좌표 -> 주소
		    var geocoder = new kakao.maps.services.Geocoder();
		    function searchDetailAddrFromCoords(coords, callback) {
		        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		    }
		</script>
		</center>
	</body>
</html>