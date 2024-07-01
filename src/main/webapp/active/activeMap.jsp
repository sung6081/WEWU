<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<!-- HEADER -->
<jsp:include page="/header.jsp"/>
<!-- HEADER -->

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
    	color: #00A06C;
    }
    
    .left {
        overflow-y: auto;
    }
    
	.switch {
	  position: relative;
	  display: inline-block;
	  width: 60px;
	  height: 34px;
	}
	
	.switch-btn {
		float:right;
	}
	
	/* Hide default HTML checkbox */
	.switch input {display:none;}
	
	/* The slider */
	.slider {
	  position: absolute;
	  cursor: pointer;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background-color: #ccc;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	.slider:before {
	  position: absolute;
	  content: "";
	  height: 26px;
	  width: 26px;
	  left: 4px;
	  bottom: 4px;
	  background-color: white;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	input.default:checked + .slider {
	  background-color: #444;
	}
	input.primary:checked + .slider {
	  background-color: #2196F3;
	}
	input.success:checked + .slider {
	  background-color: #8bc34a;
	}
	input.info:checked + .slider {
	  background-color: #3de0f5;
	}
	input.warning:checked + .slider {
	  background-color: #FFC107;
	}
	input.danger:checked + .slider {
	  background-color: #f44336;
	}
	
	input:focus + .slider {
	  box-shadow: 0 0 1px #2196F3;
	}
	
	input:checked + .slider:before {
	  -webkit-transform: translateX(26px);
	  -ms-transform: translateX(26px);
	  transform: translateX(26px);
	}
	
	/* Rounded sliders */
	.slider.round {
	  border-radius: 34px;
	}
	
	.slider.round:before {
	  border-radius: 50%;
	}
	
	.groupScrab {
	    color: #4B49Ac;
	}
	
	.mdi {
		color: #FFC100;
	}
	
	.mdi-target {
		color: #57B657;
	}
	
	.activeName {
		color: #FFC107;
	}
	
	input.default:checked + .slider {
	    background-color: #FFC107 !important;
	}
	
	.slider.round {
	    border-radius: 34px;
	    background: #00A06C !important;
	}
    
    .search { position:absolute;z-index:1000;top:20px;left:20px; }
    .search #condition { width:50px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
	.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
	.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
	.search #submit {
		background: #57B657;
		color: white;
	}
    
</style>
</head>
<body>

	<script type="text/javascript">
	
		$(document).ready(function(activeNo) {
			
			var location;
			
			var selfMarker = null;
			
			var infowindow = new naver.maps.InfoWindow();
			
			if('${groupListString}' != '') {
				groupListString = JSON.parse('${groupListString}');
			}else {
				groupListString = [];
			}
			
			if('${activeListString}' != '') {
				activeListString = JSON.parse('${activeListString}');
			}else {
				activeListString = [];
			}
			
			if('${memberListString}' != '') {
				memberListString = JSON.parse('${memberListString}');
			}else {
				memberListString = [];
			}
			
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
			    map.setZoom(15); // 지도의 줌 레벨을 변경합니다.
		
			    //infowindow.setContent('<div style="padding:20px;">' + 'geolocation.getCurrentPosition() 위치' + '</div>');
		
			    //infowindow.open(map, location);
			    
			    $('#address').val('');
			    
			    console.log('Coordinates: ' + location.toString());
			}
		
			function onErrorGeolocation() {
			    var center = map.getCenter();
		
			    //infowindow.setContent('<div style="padding:20px;">' +
			        //'<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
		
			    //infowindow.open(map, center);
			}
		
			map = new naver.maps.Map("map", {
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
		
			/* var infoWindow = new naver.maps.InfoWindow({
			    anchorSkew: true
			}); */
		
			map.setCursor('pointer');
		
			async function searchAddressToCoordinate(address) {
				
				var searchCondition = $('#condition').val();
				
				if(searchCondition == 'active') {
					
					alert('check');
					
					//var url = 'http://localhost:8080/app/active/listActive';
					var url = 'https://www.wewu.life/app/active/listActive';
					
					await $.ajax({
						
						url: url,
						method: 'POST',
						data: JSON.stringify({ searchKeyword: address }), // JSON 형식으로 변환하여 전송,
						contentType: 'application/json', // 요청 데이터의 타입을 명시
						dataType: 'json',
						success: function(res) {
							console.log(res);
							
							activeListString = res;
							
							// 기존 마커들 제거
			                for (let i = 0; i < activeMarkers.length; i++) {
			                    activeMarkers[i].setMap(null);
			                }
							
							activeMarkers = [];
							
							for(let i = 0; i < activeListString.length; i++) {
								
								let markerOptions = null;
								
								//console.log('start');
								
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
								
								var infowindow = new naver.maps.InfoWindow();
								
								//console.log("::: "+activeMarker);
								
								naver.maps.Event.addListener(activeMarker, "click", function(e) {
									
									var contentString = [
					                    '<div class="iw_inner" style="padding: 10px; font-family: Arial, sans-serif;">',
					                    '   <h3 style="margin-top: 0;">' + activeListString[i].activeName + '</h3>',
					                    '   <p><strong>모임 이름:</strong> ' + activeListString[i].groupName + '</p>',
					                    '   <p><strong>활동 시작일:</strong> ' + new Date(activeListString[i].activeStartDate).toLocaleDateString() + '</p>',
					                    '   <p><strong>활동 종료일:</strong> ' + new Date(activeListString[i].activeEndDate).toLocaleDateString() + '</p>',
					                    '   <p><strong>활동 시간:</strong> ' + activeListString[i].activeStartTime + ' ~ ' + activeListString[i].activeEndTime + '</p>',
					                    '   <button class="btn btn-success info-btn" onclick="gotoActive(' + activeListString[i].activeNo + ')" style="margin-top: 10px; margin-bottom: 10px; float: right;">활동 상세<input type="hidden" value="' + activeListString[i].activeNo + '"></button>',
					                    '</div>'
					                ].join('');
					                
					                infowindow.setContent(contentString);
									
									console.log(infowindow.getMap());
									
								    if (infowindow.getMap()) {
								    	
								        infowindow.close();
								        
								    } else {
								    	
								        infowindow.open(map, activeMarker);
								        
								        $('.info-btn').on('click', function() {
								        	
								        	var activeNo = $(this).children().val();
								        	
								        	//alert(activeNo);
								        	self.location = '/active/getActive/'+activeNo;
								        	
								        });
								    }
								});
					
								//infowindow.open(map, activeMarker);
								
								activeMarkers.push(activeMarker);
								
								//console.log(activeMarkers);
								
							}
							
						},
						error: function(xhr, status, error) {
					        // 서버 목록을 가져오는 데 실패했을 때의 처리
					        console.error('Failed to fetch server list:', error);
					    }
					});
					
					return;
					
				}
				
				var url = 'https://www.wewu.life/app/active/searchLocal?query=' + address;
				
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
				
				//console.log('start');
				
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
				
				var infowindow = new naver.maps.InfoWindow();
				
				//console.log("::: "+activeMarker);
				
				naver.maps.Event.addListener(activeMarker, "click", function(e) {
					
					var contentString = [
	                    '<div class="iw_inner" style="padding: 10px; font-family: Arial, sans-serif;">',
	                    '   <h3 style="margin-top: 0;" class="activeName">' + activeListString[i].activeName + '</h3>',
	                    '   <p><strong>모임 이름:</strong> ' + activeListString[i].groupName + '</p>',
	                    '   <p><strong>활동 시작일:</strong> ' + new Date(activeListString[i].activeStartDate).toLocaleDateString() + '</p>',
	                    '   <p><strong>활동 종료일:</strong> ' + new Date(activeListString[i].activeEndDate).toLocaleDateString() + '</p>',
	                    '   <p><strong>활동 시간:</strong> ' + activeListString[i].activeStartTime + ' ~ ' + activeListString[i].activeEndTime + '</p>',
	                    '   <button class="btn btn-success info-btn" onclick="gotoActive(' + activeListString[i].activeNo + ')" style="margin-top: 10px; margin-bottom: 10px; float: right;">활동 상세<input type="hidden" value="' + activeListString[i].activeNo + '"></button>',
	                    '</div>'
	                ].join('');
	                
	                infowindow.setContent(contentString);
					
					console.log(infowindow.getMap());
					
				    if (infowindow.getMap()) {
				    	
				        infowindow.close();
				        
				    } else {
				    	
				        infowindow.open(map, activeMarker);
				        
				        $('.info-btn').on('click', function() {
				        	
				        	var activeNo = $(this).children().val();
				        	
				        	var nick = '${user.nickname}';
							
							if(nick == '') {
								alert('로그인을 해주세요.');
								self.location = '/user/login';
								return;
							}
				        	
				        	//alert(activeNo);
				        	self.location = '/active/getActive/'+activeNo;
				        	
				        });
				    }
				});
	
				//infowindow.open(map, activeMarker);
				
				activeMarkers.push(activeMarker);
				
				//console.log(activeMarkers);
				
			}
		    
		});
	
	</script>
	
	<div class="main-panel">
       	<div class="content-wrapper">
       		<div class="row" >
				<div class="col-md-4 grid-margin stretch-card" >
				
					<div class="card">
					
		                <div class="card-body left">
		                  <h4 class="card-title">
		                  	모임 활동 리스트
		                  </h4>
		                  <div class="table-responsive">
		                  <div class="switch-btn">
		                  <p class="btn-label" style="color: #57B657;">모임/채팅</p>
		                  <label class="switch">
								<input type="checkbox" id="listChanger" class="default">
								<span class="slider round"></span>
						  </label>
						  <script type="text/javascript">
						  
						  	$('#listChanger').on('click', function() {
						  		
						  		 // 체크박스 요소를 가져옵니다.
							    let checkbox = document.getElementById('listChanger');

							    // 체크 상태를 확인합니다.
							    if (checkbox.checked) {
							        //alert('checked');
							        $('.serverTable').removeAttr('hidden');
							        $('.groupTable').attr('hidden', 'hidden');
							        $('.groupSearch').attr('hidden', 'hidden');
							        $('.more-btn').attr('hidden', 'hidden');
							        $('.card-title').html('채팅 서버 리스트');
							        $('.btn-label').html('채팅/모임');
							        $('.btn-label').css('color', '#FFC107');
							    } else {
							    	//alert('unchecked');
							    	$('.groupTable').removeAttr('hidden');
							        $('.serverTable').attr('hidden', 'hidden');
							        $('.groupSearch').removeAttr('hidden');
							        $('.more-btn').removeAttr('hidden');
							        $('.card-title').html('모임 활동 리스트');
							        $('.btn-label').html('모임/채팅');
							        $('.btn-label').css('color', '#57B657');
							    }
						  		
						  	});
						  
						  </script>
						  </div>
		                  	<div class="form-group groupSearch">
							  <div class="input-group">
							    <input type="text" id="groupSearchKeyword" class="form-control group-search" placeholder="모임 검색" aria-label="Recipient's username">
							    <div class="input-group-append">
							      <button id="groupSearchBtn" class="btn btn-sm btn-success group-btn" type="button">Search</button>
							    </div>
							  </div>
							</div>
		                  
		                  <script type="text/javascript">
		                  
		                  	
		                  
		                  </script>
		                  
		                  	<c:import url="/chat/listServer.jsp"></c:import>
		                    <table class="table groupTable">
		                      <thead>
		                        <tr>
		                          <th>No</th>
		                          <th>모임 이름</th>
		                          <th>모임장</th>
		                          <th>스크랩</th>
		                        </tr>
		                      </thead>
		                      <tbody class="groupList">
		                      	<c:set var="i" value="1"></c:set>
		                        <c:forEach var="group" items="${groupList}">
		                        	<tr>
		                        		<td class="numb">${i}</td>
		                        		<td class="group-name">
		                        			${group.groupName}
		                        			<input type="hidden" value="${group.groupNo}" >
		                        		</td>
		                        		<td>${group.leaderNick}</td>
		                        		<td class="clickable-text groupScrab">
		                        			<c:if test="${user != null and memberList[i-1].scrabFlag == 'Y'}">
		                        				<i class="mdi mdi-star"></i>
		                        			</c:if>
		                        			<c:if test="${user == null or memberList[i-1].scrabFlag != 'Y'}">
		                        				<i class="mdi mdi-star-outline"></i>
		                        			</c:if>
		                        			<c:if test="${memberList[i-1] != null}">
		                        				<input type="hidden" value="${memberList[i-1].memberNo}">
		                        			</c:if>
		                        			<c:if test="${memberList[i-1] == null}">
		                        				<input type="hidden" value="0">
		                        			</c:if>
		                        		</td>
		                        	</tr>
		                        <c:set var="i" value="${i+1}"></c:set>
		                        </c:forEach>
		                      </tbody>
		                    </table>
		                    <c:if test="${!isLast}">
			                    <button type="button" class="more-btn btn btn-secondary btn-lg btn-block">
	                    			더보기
	                    		</button>
                    		</c:if>
		                  </div>
		                </div>
		                
		              </div>
		              
				</div>
				
				<script type="text/javascript">
				
					searchKeyword = '';
	              	currentPage = 1;
	              
	              	$('.group-search').on('keydown', function(e) {
	    		        var keyCode = e.which;
	    				
	    		        if (keyCode === 13) { // Enter Key
	    		        	
	    		        	$('.group-btn').click();
	    		        }
	    		    });
	              
	              	$('.group-btn').click(async function() {
	              		
	              		searchKeyword = $('.group-search').val();
	              		
	              		//alert('search');
	              		
	              		if(searchKeyword == '') {
	              			return;
	              		}
	              		
	              		$('.group-search').val('');
	              		currentPage = 1;
	              		
	              		//var url = 'http://localhost:8080/app/active/listGroup';
	              		var url = 'https://www.wewu.life/app/active/listGroup';
	              		
	              		await $.ajax({
	              			
	              			url: url,
	              			type: "POST",
	              			data: JSON.stringify({
	              				searchKeyword: searchKeyword,
	              				currentPage: 1
	              			}),
	              			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
	    					dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
	    					success : function(data, status, xhr) {
	    						console.log("::: "+data.groupList);
	    						console.log("::: "+data.memberList);
	    						console.log("::: "+data.isLast);
	    						
	    						$('.groupList').children().remove();
								
	    						var newTable = '';
	    						
	    						var groupList = data.groupList;
	    						var memberList = data.memberList;
	    						var isLast = data.isLast;
	    						
	    						if(isLast) {
	    							$('.more-btn').attr('hidden', 'hidden');
	    						}else {
	    							$('.more-btn').removeAttr('hidden');
	    						}
	    						
	    						for(let i = 0; i < groupList.length; i++) {
	    							
	    							var scrabFlag = 'N';
	    							var memberNo = 0;
	    							var scrabElement = '';
	    							
	    							console.log(memberList);
	    							
	    							if(memberList[i] != null) {
	    								memberNo = memberList[i].memberNo;
	    								scrabFlag = memberList[i].scrabFlag;
	    							}
	    							
	    							if(scrabFlag == 'Y') {
	    								scrabElement += '<i class="mdi mdi-star"></i>\n'+
	    												'<input type="hidden" value="'+memberNo+'">\n';
	    							} else {
	    								scrabElement += '<i class="mdi mdi-star-outline"></i>\n'+
														'<input type="hidden" value="'+memberNo+'">\n';
	    							}
	    							
	    							newTable += '<tr>\n'+
	    											'<td class="numb">'+(i+1)+'</td>\n'+
	    											'<td class="group-name clickable-text">'+groupList[i].groupName+'<input type="hidden" value="'+groupList[i].groupNo+'" ></td>\n'+
	    											'<td>'+groupList[i].leaderNick+'</td>\n'+
	    											'<td class="clickable-text groupScrab">\n'+
	    											scrabElement+'\n'+
	    											'</td>\n'+
	    										'</tr>';
	    							
	    						}
	    						
	    						$('.groupList').append(newTable);
	    						
	    						$('.groupScrab').on('click', function() {
	    							
	    							//alert($($(this).children()[1]).val());
	    							
	    							var memberNo = $($(this).children()[1]).val();
	    							
	    							if(memberNo == 0) {
	    								alert('모임 회원이 아니라면 스크랩할 수 없습니다.');
	    								
	    								return;
	    							}
	    							
	    							var scrabStar = $($(this).children()[0]);
	    							
	    							var scrabFlag = 'N';
	    							
	    							if(scrabStar.hasClass('mdi-star-outline')) {
	    								scrabFlag = 'Y';
	    							}
	    							
	    							//alert(scrabFlag);
	    							
	    							$.ajax ({
	    								url	: "/app/group/updateScrab", // (Required) 요청이 전송될 URL 주소
	    								type  : "POST", // (default: ‘GET’) http 요청 방식
	    								async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
	    								cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
	    								timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
	    								data  : JSON.stringify(
	    								 			{
	    								 				memberNo:memberNo,
	    								 				scrabFlag:scrabFlag
	    								 			}
	    								 		), // 요청 시 전달할 데이터
	    								processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
	    								contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
	    								dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
	    								beforeSend  : function () {
	    								  // XHR Header 포함, HTTP Request 하기전에 호출
	    								  
	    								},
	    								success : function(data, status, xhr) {
	    									
	    									if(scrabStar.hasClass('mdi-star-outline')) {
	    										scrabStar.removeClass('mdi-star-outline');
	    										scrabStar.addClass('mdi-star');
	    									}else {
	    										scrabStar.removeClass('mdi-star');
	    										scrabStar.addClass('mdi-star-outline');
	    									}
	    									
	    								},
	    								error	: function(xhr, status, error) {
	    								  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
	    								},
	    								complete : function(xhr, status) {
	    								  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
	    								}
	    							});
	    							
	    						});
	    						
	    						
	    					},
	    					error	: function(xhr, status, error) {
	    					  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
	    					  console.log(error);
	    					}
	              		});
	              		
	              		$('.group-name').click(function(event) {
					        
							var currentRow = $(this).closest('tr');
					        var infoRow = currentRow.next('.info-row');
					        var groupNo = $(this).children().val();
					        
					        //alert(currentRow.html());
					        
					        var activeList = [];
					        
					        //console.log(groupNo);
					        
					        $.ajax ({
								url	: "/app/active/listAllGroupActive/"+groupNo, // (Required) 요청이 전송될 URL 주소
								type  : "POST", // (default: ‘GET’) http 요청 방식
								async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
								cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
								timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
								data  : JSON.stringify(
								 			{
								 				
								 			}
								 		), // 요청 시 전달할 데이터
								processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
								contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
								dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
								beforeSend  : function () {
								  // XHR Header 포함, HTTP Request 하기전에 호출
								  
								},
								success : function(data, status, xhr) {
									
									// 이미 정보 행이 있는 경우 제거
							        if (infoRow.length) {
							        	$('.info-row').remove();
							            return;
							        }
									
									$('.info-row').remove();
									
									if(data.length == 0) {
										//alert('등록된 활동이 없습니다.');
									}
				
							        // 새로운 정보 행 생성
							        var newInfoRow = '';
							        
							        console.log(data);
							        
							        for(let i = 0; i < data.length; i++) {
							        	newInfoRow += '<tr class="info-row">\n'+
							        					'<td><i class="mdi mdi-subdirectory-arrow-right"></i>활동</td>\n'+
							        					'<td class="clickable-text activeName">'+data[i].activeName+'<input type="hidden" value="'+data[i].activeX+'"><input type="hidden" value="'+data[i].activeY+'"></td>\n'+
							        					'<td>'+data[i].activeStartDate+'</td>\n'+
							        					'<td>'+data[i].activeEndDate+'</td>\n'+
							        				   '</tr>'
							        }
				
							        // 현재 행 바로 아래에 정보 행 추가
							        currentRow.after(newInfoRow);
							        
							        $('.activeName').on('click', function() {
										
										var activeX = $($(this).children()[0]).val();
										var activeY = $($(this).children()[1]).val();
										
										//alert(activeX);
										//alert(activeY);
										
										var point = new naver.maps.LatLng(activeX,activeY);
										
										map.setCenter(point);
										
									});
									
								},
								error	: function(xhr, status, error) {
								  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
								},
								complete : function(xhr, status) {
								  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
								}
							});
		
					        
					    });
	              		
	              	});
				
					$('.more-btn').on('click', function() {
						
	              		currentPage++;
	              		
	              		//alert(currentPage);
	              		
	              		$.ajax ({
							url	: "/app/active/listGroup", 
							type  : "POST", 
							data  : JSON.stringify(
							 			{
							 				currentPage: currentPage,
							 				searchKeyword: searchKeyword
							 			}
							 		), // 요청 시 전달할 데이터
							processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
							contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
							dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
							beforeSend  : function () {
							  // XHR Header 포함, HTTP Request 하기전에 호출
							  
							},
							success : function(data, status, xhr) {
								
								console.log("::: "+data.groupList);
	    						console.log("::: "+data.memberList);
	    						console.log("::: "+data.isLast);
								
	    						var newTable = '';
	    						
	    						var groupList = data.groupList;
	    						var memberList = data.memberList;
	    						var isLast = data.isLast;
	    						
	    						if(isLast) {
	    							$('.more-btn').attr('hidden', 'hidden');
	    						}else {
	    							$('.more-btn').removeAttr('hidden');
	    						}
	    						
	    						for(let i = 0; i < groupList.length; i++) {
	    							
	    							var scrabFlag = 'N';
	    							var memberNo = 0;
	    							var scrabElement = '';
	    							
	    							console.log(memberList);
	    							
	    							if(memberList[i] != null) {
	    								memberNo = memberList[i].memberNo;
	    								scrabFlag = memberList[i].scrabFlag;
	    							}
	    							
	    							if(scrabFlag == 'Y') {
	    								scrabElement += '<i class="mdi mdi-star"></i>\n'+
	    												'<input type="hidden" value="'+memberNo+'">\n';
	    							} else {
	    								scrabElement += '<i class="mdi mdi-star-outline"></i>\n'+
														'<input type="hidden" value="'+memberNo+'">\n';
	    							}
	    							
	    							newTable += '<tr class="appendTable">\n'+
	    											'<td class="numb">'+((currentPage - 1) * 10 + i + 1)+'</td>\n'+
	    											'<td class="group-name clickable-text">'+groupList[i].groupName+'<input type="hidden" value="'+groupList[i].groupNo+'" ></td>\n'+
	    											'<td>'+groupList[i].leaderNick+'</td>\n'+
	    											'<td class="clickable-text groupScrab">\n'+
	    											scrabElement+'\n'+
	    											'</td>\n'+
	    										'</tr>';
	    							
	    						}
	    						
	    						$('.groupList').append(newTable);
	    						
	    						$('.group-name').click(function(event) {
	    					        
	    							var currentRow = $(this).closest('tr');
	    					        var infoRow = currentRow.next('.info-row');
	    					        var groupNo = $(this).children().val();
	    					        
	    					        //alert(currentRow.html());
	    					        
	    					        var activeList = [];
	    					        
	    					        //console.log(groupNo);
	    					        
	    					        $.ajax ({
	    								url	: "/app/active/listAllGroupActive/"+groupNo, // (Required) 요청이 전송될 URL 주소
	    								type  : "POST", // (default: ‘GET’) http 요청 방식
	    								async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
	    								cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
	    								timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
	    								data  : JSON.stringify(
	    								 			{
	    								 				
	    								 			}
	    								 		), // 요청 시 전달할 데이터
	    								processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
	    								contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
	    								dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
	    								beforeSend  : function () {
	    								  // XHR Header 포함, HTTP Request 하기전에 호출
	    								  
	    								},
	    								success : function(data, status, xhr) {
	    									
	    									// 이미 정보 행이 있는 경우 제거
	    							        if (infoRow.length) {
	    							        	$('.info-row').remove();
	    							            return;
	    							        }
	    									
	    									$('.info-row').remove();
	    									
	    									if(data.length == 0) {
	    										//alert('등록된 활동이 없습니다.');
	    									}
	    				
	    							        // 새로운 정보 행 생성
	    							        var newInfoRow = '';
	    							        
	    							        console.log(data);
	    							        
	    							        for(let i = 0; i < data.length; i++) {
	    							        	newInfoRow += '<tr class="info-row">\n'+
	    							        					'<td><i class="mdi mdi-subdirectory-arrow-right"></i>활동</td>\n'+
	    							        					'<td class="clickable-text activeName">'+data[i].activeName+'<input type="hidden" value="'+data[i].activeX+'"><input type="hidden" value="'+data[i].activeY+'"></td>\n'+
	    							        					'<td>'+data[i].activeStartDate+'</td>\n'+
	    							        					'<td>'+data[i].activeEndDate+'</td>\n'+
	    							        				   '</tr>'
	    							        }
	    				
	    							        // 현재 행 바로 아래에 정보 행 추가
	    							        currentRow.after(newInfoRow);
	    							        
	    							        $('.activeName').on('click', function() {
	    										
	    										var activeX = $($(this).children()[0]).val();
	    										var activeY = $($(this).children()[1]).val();
	    										
	    										//alert(activeX);
	    										//alert(activeY);
	    										
	    										var point = new naver.maps.LatLng(activeX,activeY);
	    										
	    										map.setCenter(point);
	    										
	    									});
	    									
	    								},
	    								error	: function(xhr, status, error) {
	    								  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
	    								},
	    								complete : function(xhr, status) {
	    								  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
	    								}
	    							});
	    		
	    					        
	    					    });
	    						
	    						$('.groupScrab').on('click', function() {
	    							
	    							//alert($($(this).children()[1]).val());
	    							
	    							var memberNo = $($(this).children()[1]).val();
	    							
	    							if(memberNo == 0) {
	    								alert('모임 회원이 아니라면 스크랩할 수 없습니다.');
	    								
	    								return;
	    							}
	    							
	    							var scrabStar = $($(this).children()[0]);
	    							
	    							var scrabFlag = 'N';
	    							
	    							if(scrabStar.hasClass('mdi-star-outline')) {
	    								scrabFlag = 'Y';
	    							}
	    							
	    							//alert(scrabFlag);
	    							
	    							$.ajax ({
	    								url	: "/app/group/updateScrab", // (Required) 요청이 전송될 URL 주소
	    								type  : "POST", // (default: ‘GET’) http 요청 방식
	    								async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
	    								cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
	    								timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
	    								data  : JSON.stringify(
	    								 			{
	    								 				memberNo:memberNo,
	    								 				scrabFlag:scrabFlag
	    								 			}
	    								 		), // 요청 시 전달할 데이터
	    								processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
	    								contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
	    								dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
	    								beforeSend  : function () {
	    								  // XHR Header 포함, HTTP Request 하기전에 호출
	    								  
	    								},
	    								success : function(data, status, xhr) {
	    									
	    									if(scrabStar.hasClass('mdi-star-outline')) {
	    										scrabStar.removeClass('mdi-star-outline');
	    										scrabStar.addClass('mdi-star');
	    									}else {
	    										scrabStar.removeClass('mdi-star');
	    										scrabStar.addClass('mdi-star-outline');
	    									}
	    									
	    								},
	    								error	: function(xhr, status, error) {
	    								  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
	    								},
	    								complete : function(xhr, status) {
	    								  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
	    								}
	    							});
	    							
	    						});
								
							},
							error	: function(xhr, status, error) {
							  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
							},
							complete : function(xhr, status) {
							  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
							}
						});
	              		
	              	});
				
					$('.groupScrab').on('click', function() {
						
						//alert($($(this).children()[1]).val());
						
						var memberNo = $($(this).children()[1]).val();
						
						if(memberNo == 0) {
							alert('모임 회원이 아니라면 스크랩할 수 없습니다.');
							
							return;
						}
						
						var scrabStar = $($(this).children()[0]);
						
						var scrabFlag = 'N';
						
						if(scrabStar.hasClass('mdi-star-outline')) {
							scrabFlag = 'Y';
						}
						
						//alert(scrabFlag);
						
						$.ajax ({
							url	: "/app/group/updateScrab", // (Required) 요청이 전송될 URL 주소
							type  : "POST", // (default: ‘GET’) http 요청 방식
							async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
							cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
							timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
							data  : JSON.stringify(
							 			{
							 				memberNo:memberNo,
							 				scrabFlag:scrabFlag
							 			}
							 		), // 요청 시 전달할 데이터
							processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
							contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
							dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
							beforeSend  : function () {
							  // XHR Header 포함, HTTP Request 하기전에 호출
							  
							},
							success : function(data, status, xhr) {
								
								if(scrabStar.hasClass('mdi-star-outline')) {
									scrabStar.removeClass('mdi-star-outline');
									scrabStar.addClass('mdi-star');
								}else {
									scrabStar.removeClass('mdi-star');
									scrabStar.addClass('mdi-star-outline');
								}
								
							},
							error	: function(xhr, status, error) {
							  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
							},
							complete : function(xhr, status) {
							  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
							}
						});
						
					});
					
					$('.serverTable').attr('hidden', 'hidden');
				
					$('.group-name').click(function(event) {
				        
						var currentRow = $(this).closest('tr');
				        var infoRow = currentRow.next('.info-row');
				        var groupNo = $(this).children().val();
				        
				        //alert(currentRow.html());
				        
				        var activeList = [];
				        
				        //console.log(groupNo);
				        
				        $.ajax ({
							url	: "/app/active/listAllGroupActive/"+groupNo, // (Required) 요청이 전송될 URL 주소
							type  : "POST", // (default: ‘GET’) http 요청 방식
							async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
							cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
							timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
							data  : JSON.stringify(
							 			{
							 				
							 			}
							 		), // 요청 시 전달할 데이터
							processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
							contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
							dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
							beforeSend  : function () {
							  // XHR Header 포함, HTTP Request 하기전에 호출
							  
							},
							success : function(data, status, xhr) {
								
								// 이미 정보 행이 있는 경우 제거
						        if (infoRow.length) {
						        	$('.info-row').remove();
						            return;
						        }
								
								$('.info-row').remove();
								
								if(data.length == 0) {
									//alert('등록된 활동이 없습니다.');
								}
			
						        // 새로운 정보 행 생성
						        var newInfoRow = '';
						        
						        console.log(data);
						        
						        for(let i = 0; i < data.length; i++) {
						        	newInfoRow += '<tr class="info-row">\n'+
						        					'<td><i class="mdi mdi-subdirectory-arrow-right"></i>활동</td>\n'+
						        					'<td class="clickable-text activeName">'+data[i].activeName+'<input type="hidden" value="'+data[i].activeX+'"><input type="hidden" value="'+data[i].activeY+'"></td>\n'+
						        					'<td>'+data[i].activeStartDate+'</td>\n'+
						        					'<td>'+data[i].activeEndDate+'</td>\n'+
						        				   '</tr>'
						        }
			
						        // 현재 행 바로 아래에 정보 행 추가
						        currentRow.after(newInfoRow);
						        
						        $('.activeName').on('click', function() {
									
									var activeX = $($(this).children()[0]).val();
									var activeY = $($(this).children()[1]).val();
									
									//alert(activeX);
									//alert(activeY);
									
									var point = new naver.maps.LatLng(activeX,activeY);
									
									map.setCenter(point);
									
								});
								
							},
							error	: function(xhr, status, error) {
							  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
							},
							complete : function(xhr, status) {
							  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
							}
						});
	
				        
				    });
					
					$('.group-name').addClass('clickable-text');
				
				</script>
				
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
