<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">

<title>모임 활동 지도</title>
<!-- 필요한 메타 데이터 및 CSS/JS 링크 포함 -->
<link rel="stylesheet" href="/vendors/mdi/css/materialdesignicons.min.css">
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${clientId}&submodules=panorama,geocoder"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<style>

	html {
	    overflow: hidden;
	}
	
	.btn_mylct i {
        font-size: 50px; /* 아이콘 크기를 키웁니다 */
    }
    
    .clickable-text {
        cursor: pointer; /* 커서를 포인터로 변경하여 클릭 가능함을 나타냄 */
    }
    
    .group-name {
    	color: blue;
    }
    
    .left {
        overflow-y: auto;
    }
    
    .search { position:absolute;z-index:1000;top:20px;left:20px; }
    .search #condition { width:50px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
	.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
	.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
    
</style>
</head>
<body>

	<div id="header">
	    <c:import url="/header.jsp"></c:import>
	</div>
	
	<script type="text/javascript">

	$(document).ready(function() {
		
		var location;
		
		var selfMarker = null;
		
		var groupListString = JSON.parse('${groupListString}');
	
		var activeListString = JSON.parse('${activeListString}');
		
		var memberListString = JSON.parse('${memberListString}');
		
		console.log(groupListString);
		
		console.log(activeListString);
		
		console.log(memberListString);
		
		var height = $(window).height() - 300;
		
		console.log(height);
		
		$('#map').height(height);
		
		//for()
		
		if (navigator.geolocation) {
	        /**
	         * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
	         * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
	         * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
	         */
	        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
	    } else {
	        var center = map.getCenter();
	        //infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
	        //infowindow.open(map, center);
	    }
		
		function onSuccessGeolocation(position) {
		    location = new naver.maps.LatLng(position.coords.latitude,
		                                         position.coords.longitude);
		    
		    if(selfMarker) {
		    	selfMarker.setMap(null);
		    }
		    
		    selfMarker = new naver.maps.Marker({
		        position: location,
		        map: map
		    });
	
		    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
		    //map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
	
		    //infowindow.setContent('<div style="padding:20px;">' + 'geolocation.getCurrentPosition() 위치' + '</div>');
	
		    //infowindow.open(map, location);
		    
		    
		    
		    console.log('Coordinates: ' + location.toString());
		}
	
		function onErrorGeolocation() {
		    var center = map.getCenter();
	
		    //infowindow.setContent('<div style="padding:20px;">' +
		        //'<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
	
		    //infowindow.open(map, center);
		}
	
		var map = new naver.maps.Map("map", {
		    center: new naver.maps.LatLng(37.3595316, 127.1052133),
		    zoom: 15,
		    mapTypeControl: true
		});
		
		var locationBtnHtml = '<a href="#" class="btn_mylct"><i class="mdi mdi-target"></i></a>';
		//var map = new naver.maps.Map('map', {zoom: 13});
	
		naver.maps.Event.once(map, 'init', function() {
		    //customControl 객체 이용하기
		    /* var customControl = new naver.maps.CustomControl(locationBtnHtml, {
		        position: naver.maps.Position.TOP_LEFT
		    });
	
		    customControl.setMap(map); */
	
		    /* naver.maps.Event.addDOMListener(customControl.getElement(), 'click', function() {
		        map.setCenter(new naver.maps.LatLng(37.3595953, 127.1053971));
		    }); */
	
		    //Map 객체의 controls 활용하기
		    var $locationBtn = $(locationBtnHtml),
		        locationBtnEl = $locationBtn[0];
	
		    map.controls[naver.maps.Position.RIGHT_BOTTOM].push(locationBtnEl);
	
		    naver.maps.Event.addDOMListener(locationBtnEl, 'click', function() {
		    	if (navigator.geolocation) {
		            /**
		             * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
		             * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
		             * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
		             */
		            navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
		        } else {
		            var center = map.getCenter();
		            //infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
		            //infowindow.open(map, center);
		        }
		    });
		});
	
		var infoWindow = new naver.maps.InfoWindow({
		    anchorSkew: true
		});
	
		map.setCursor('pointer');
	
		async function searchAddressToCoordinate(address) {
			
			var url = 'http://localhost:8080/app/active/searchLocal?query=' + address;
			
			var local;
			
			await $.ajax({
				url: url,
				method: 'GET',
				success: function(response) {
					
					console.log(response);
					//console.log(response.mapX);
					//console.log(response.address);
					
					local = response.address;
					
					//var point = new naver.maps.Point(response.mapX, response.mapY);
					
					//map.setCenter(point);
					
				},
			    error: function(xhr, status, error) {
			        // 서버 목록을 가져오는 데 실패했을 때의 처리
			        console.error('Failed to fetch server list:', error);
			    }
			});
			
		    naver.maps.Service.geocode({
		        query: local
		    }, function(status, response) {
		    	
		        if (status === naver.maps.Service.Status.ERROR) {
		            return alert('Something Wrong!');
		        }
	
		        if (response.v2.meta.totalCount === 0) {
		            return alert('totalCount' + response.v2.meta.totalCount);
		        }
	
		        var htmlAddresses = [],
		            item = response.v2.addresses[0],
		            point = new naver.maps.Point(item.x, item.y);
	
		        if (item.roadAddress) {
		            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		        }
	
		        if (item.jibunAddress) {
		            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
		        }
	
		        if (item.englishAddress) {
		            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
		        }
	
		        /* infoWindow.setContent([
		            '<div style="padding:10px;min-width:200px;line-height:150%;">',
		            '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
		            htmlAddresses.join('<br />'),
		            '</div>'
		        ].join('\n'));*/
	
		        map.setCenter(point);
		        //infoWindow.open(map, point);
		    });
		    
		}
	
		function initGeocoder() {
	
		    $('#address').on('keydown', function(e) {
		        var keyCode = e.which;
	
		        if (keyCode === 13) { // Enter Key
		        	
		            searchAddressToCoordinate($('#address').val());
		        }
		    });
	
		    $('#submit').on('click', function(e) {
		    	
		        e.preventDefault();
	
		        searchAddressToCoordinate($('#address').val());
		    });
			
		    if (!navigator.geolocation) {
		    	searchAddressToCoordinate('강남');
		    }
		    
		}
	
		function makeAddress(item) {
		    if (!item) {
		        return;
		    }
	
		    var name = item.name,
		        region = item.region,
		        land = item.land,
		        isRoadAddress = name === 'roadaddr';
	
		    var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';
	
		    if (hasArea(region.area1)) {
		        sido = region.area1.name;
		    }
	
		    if (hasArea(region.area2)) {
		        sigugun = region.area2.name;
		    }
	
		    if (hasArea(region.area3)) {
		        dongmyun = region.area3.name;
		    }
	
		    if (hasArea(region.area4)) {
		        ri = region.area4.name;
		    }
	
		    if (land) {
		        if (hasData(land.number1)) {
		            if (hasData(land.type) && land.type === '2') {
		                rest += '산';
		            }
	
		            rest += land.number1;
	
		            if (hasData(land.number2)) {
		                rest += ('-' + land.number2);
		            }
		        }
	
		        if (isRoadAddress === true) {
		            if (checkLastString(dongmyun, '면')) {
		                ri = land.name;
		            } else {
		                dongmyun = land.name;
		                ri = '';
		            }
	
		            if (hasAddition(land.addition0)) {
		                rest += ' ' + land.addition0.value;
		            }
		        }
		    }
	
		    return [sido, sigugun, dongmyun, ri, rest].join(' ');
		}
	
		function hasArea(area) {
		    return !!(area && area.name && area.name !== '');
		}
	
		function hasData(data) {
		    return !!(data && data !== '');
		}
	
		function checkLastString (word, lastString) {
		    return new RegExp(lastString + '$').test(word);
		}
	
		function hasAddition (addition) {
		    return !!(addition && addition.value);
		}
	
		naver.maps.onJSContentLoaded = initGeocoder;
		
activeMarkers = [];
		
		for(let i = 0; i < activeListString.length; i++) {
			
			let markerOptions = null;
			
			console.log('start');
			
			if(activeListString[i].activeShortUrl != null) {
			
				markerOptions = {
				    position: new naver.maps.LatLng(activeListString[i].activeX, activeListString[i].activeY),
				    map: map,
				    icon: {
				        url: activeListString[i].activeShortUrl,
				        size: new naver.maps.Size(50, 50), // 원래 이미지 크기
				        scaledSize: new naver.maps.Size(50, 50), // 조정된 이미지 크기
				        origin: new naver.maps.Point(0, 0), // 이미지의 원점
				        anchor: new naver.maps.Point(25, 50) // 마커 이미지의 앵커 포인트
				    }
				};
				
				//console.log("::: "+markerOptions);
			
			}else {
				
				let iconSpritePositionX = 1;
			    let iconSpritePositionY = 1;
				
				markerOptions = {
				    position: new naver.maps.LatLng(activeListString[i].activeX, activeListString[i].activeY),
				    map: map,
				    icon: {
				    	url: '/images/icon/sp_pin_hd.png',
				          size: new naver.maps.Size(26, 36), // 이미지 크기
				          origin: new naver.maps.Point(iconSpritePositionX, iconSpritePositionY), // 스프라이트 이미지에서 클리핑 위치
				          anchor: new naver.maps.Point(13, 36), // 지도상 위치에서 이미지 위치의 offset
				          scaledSize: new naver.maps.Size(395, 79)
				    }
				};
				
				//console.log("::: "+markerOptions);
				
			}
			
			let activeMarker = new naver.maps.Marker(markerOptions);
			
			console.log("::: "+activeMarker);
			
			activeMarkers.push(activeMarker);
			
			console.log(activeMarkers);
			
		}
	    
	});
	
	</script>
	
	<div class="main-panel">
       	<div class="content-wrapper">
       		<div class="row" >
				<div class="col-md-4 grid-margin stretch-card" >
				
					<div class="card">
					
		                <div class="card-body left">
		                  <h4 class="card-title">모임 목록 리스트</h4>
		                  <div class="table-responsive">
		                  <form >
		                  	<div class="form-group">
							  <div class="input-group">
							    <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username">
							    <div class="input-group-append">
							      <button class="btn btn-sm btn-primary" type="button">Search</button>
							    </div>
							  </div>
							</div>
		                  </form>
		                    <table class="table">
		                      <thead>
		                        <tr>
		                          <th>No</th>
		                          <th>모임 이름</th>
		                          <th>모임장</th>
		                          <th></th>
		                        </tr>
		                      </thead>
		                      <tbody class="groupList">
		                      	<c:set var="i" value="1"></c:set>
		                        <c:forEach var="group" items="${groupList}">
		                        	<tr>
		                        		<td>${i}</td>
		                        		<td class="clickable-text group-name">${group.groupName}</td>
		                        		<td>${group.leaderNick}</td>
		                        		<td class="clickable-text"><i class="mdi mdi-star-outline"></i><i class="mdi mdi-star"></i></td>
		                        	</tr>
		                        <c:set var="i" value="${i+1}"></c:set>
		                        </c:forEach>
		                      </tbody>
		                    </table>
		                  </div>
		                </div>
		                
		              </div>
		              
				</div>
				
				<div class="col-md-8 grid-margin right" >
					
					<div id="map">
				        <div class="search">
				        	<select id="condition" >
				        		<option value="map" >지도</option>
				        		<option value="active" >활동</option>
				        	</select>
				            <input id="address" type="text" placeholder="검색할 주소" value="강남" />
				            <input id="submit" type="button" value="주소 검색" />
				        </div>
				    </div>
			    
			    </div>
			    
			</div>
       	</div>
    </div>
	
	<div id="footer">
	    <c:import url="/footer.jsp"></c:import>
	</div>

</body>
<script>
    $(document).ready(function() {
        function adjustLeftPanelHeight() {
            var rightPanelHeight = $('#map').outerHeight();
            $('.left').height(rightPanelHeight);
        }

        adjustLeftPanelHeight();

        // 창 크기 변경 시 높이 조정
        $(window).resize(function() {
            adjustLeftPanelHeight();
        });
    });
</script>
</html>
