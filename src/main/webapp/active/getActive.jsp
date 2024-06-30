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
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${clientId}&submodules=panorama,geocoder"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/vendors/mdi/css/materialdesignicons.min.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<link rel="stylesheet" href="/css/datepicker.css">

<style>

	.btn_mylct i {
        font-size: 50px; /* 아이콘 크기를 키웁니다 */
    }
    
    .text-center {
        text-align: center;
    }

    #map {
        width: 100%;
        height: 500px;
    }
    
    .mdi-target {
		color: #57B657;
	}
	
	input {
		background: white !important;
	}
    
    .search { position:absolute;z-index:1000;top:20px;left:20px; }
	.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
	.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
	.search #submit {
		background: #57B657 !important;
		color: white;
	}
    
</style>

</head>
<body>

	<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
	<script type="text/javascript">
	
	/* $.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear: true,
		yearSuffix: '년'
	});
	
	$(function () {
		$('.datepicker').datepicker({
			inline: true
		});
	}); */
	
	$(document).ready(function() {
	    var location;
	    var activeMarker = null;
	    var map_x = ${active.activeX};
	    var map_y = ${active.activeY};
	    var map = new naver.maps.Map("map", {
	        center: new naver.maps.LatLng(map_x, map_y),
	        zoom: 15,
	        mapTypeControl: true
	    });

	    var markerOptions;
	    if ('${active.activeShortUrl}') {
	        markerOptions = {
	            position: new naver.maps.LatLng(map_x, map_y),
	            map: map,
	            icon: {
	                url: '${active.activeShortUrl}',
	                size: new naver.maps.Size(50, 50),
	                scaledSize: new naver.maps.Size(50, 50),
	                origin: new naver.maps.Point(0, 0),
	                anchor: new naver.maps.Point(25, 50)
	            }
	        };
	    } else {
	        let iconSpritePositionX = 1;
	        let iconSpritePositionY = 1;
	        markerOptions = {
	            position: new naver.maps.LatLng(map_x, map_y),
	            map: map,
	            icon: {
	                url: '/images/icon/sp_pin_hd.png',
	                size: new naver.maps.Size(26, 36),
	                origin: new naver.maps.Point(iconSpritePositionX, iconSpritePositionY),
	                anchor: new naver.maps.Point(13, 36),
	                scaledSize: new naver.maps.Size(395, 79)
	            }
	        };
	    }

	    activeMarker = new naver.maps.Marker(markerOptions);

	    var locationBtnHtml = '<a href="#" class="btn_mylct"><i class="mdi mdi-target"></i></a>';

	    naver.maps.Event.once(map, 'init', function() {
	        var $locationBtn = $(locationBtnHtml),
	            locationBtnEl = $locationBtn[0];

	        map.controls[naver.maps.Position.RIGHT_BOTTOM].push(locationBtnEl);

	        naver.maps.Event.addDOMListener(locationBtnEl, 'click', function(e) {
	            e.preventDefault(); // 기본 동작 방지

	            var markerLocation = new naver.maps.LatLng(map_x, map_y);
	            $('#address').val('');
	            map.setCenter(markerLocation);
	        });
	    });

	    var infoWindow = new naver.maps.InfoWindow({
	        anchorSkew: true
	    });

	    map.setCursor('pointer');

	    async function searchAddressToCoordinate(address) {
	        var url = 'https://www.wewu.life/app/active/searchLocal?query=' + address;
	        var local;

	        await $.ajax({
	            url: url,
	            method: 'GET',
	            success: function(response) {
	                local = response.address;
	            },
	            error: function(xhr, status, error) {
	                console.error('Failed to fetch server list:', error);
	            }
	        });

	        naver.maps.Service.geocode({
	            query: local
	        }, function(status, response) {
	            var item = response.v2.addresses[0],
	                point = new naver.maps.Point(item.x, item.y);

	            map.setCenter(point);
	        });
	    }

	    function initGeocoder() {
	        $('#address').on('keydown', function(e) {
	            var keyCode = e.which;
	            if (keyCode === 13) {
	                searchAddressToCoordinate($('#address').val());
	            }
	        });

	        $('#submit').on('click', function(e) {
	            e.preventDefault();
	            searchAddressToCoordinate($('#address').val());
	        });
	    }

	    naver.maps.onJSContentLoaded = initGeocoder;
	});
	
	</script>
	
	<!-- SIDE -->
	<jsp:include page="/group/groupSide.jsp"></jsp:include>
	<!-- SIDE -->
	
	<div class="main-panel">
	
       	<div class="content-wrapper">
       	
       		<form class="add-form" >
       		
	       		<div class="row" >
	       		
	       			<div class="col-md-12 grid-margin" >
	       				<h4>활동 상세 정보</h4>
	       			</div>
	       			
					<div class="col-md-5 grid-margin" >
					
						<div class="row">
						
							<div class="col-md-6 grid-margin" >
								<div class="form-group">
			                      <label>활동 이름</label>
			                      <input type="text" readonly="readonly" name="activeName" class="form-control" value="${active.activeName}" placeholder="활동 이름">
			                      <input type="hidden" name="groupNo" value="${groupNo}" >
			                      <input type="hidden" class="activeLocal" name="activeLocal" value="${active.activeLocal}" >
			                      <input type="hidden" class="activeX" name="activeX" value="${active.activeX}" >
			                      <input type="hidden" class="activeY" name="activeY" value="${active.activeY}" >
			                    </div>
		                    </div>
		                    <div class="col-md-5 grid-margin" >
			                    <div class="form-group">
			                      <label>그룹장 닉네임</label>
			                      <input type="text" name="leaderNick" disabled="disabled" class="form-control" value="${active.leaderNick}">
			                    </div>
			               	</div>
			               	
	                    </div>
	                    
	                    <div class="form-group">
	                    	
	                   		<label>모임시간</label>
	                   		
	                   		<div class="row">
	                   		
	                    		<div class="col-md-5 grid-margin" >
	                    			<input type="time" readonly="readonly" name="activeStartTime" class="time form-control" value="${active.activeStartTime}" >
	                    		</div>
	                    		<div class="col-md-1 grid-margin" >
	                    			<!-- <br/> -->
	                    			<!-- <span style="display: flex; justify-content: center; align-items: center;" >~</span> -->
	                    		</div>
	                    		<div class="col-md-5 grid-margin" >
	                    			<input type="time" readonly="readonly" name="activeEndTime" class="time form-control" value="${active.activeEndTime}" >
	                    		</div>
	                    		
	                   		</div>
	                   		
	                   		<div class="row">
	                   		
	                    		<div class="col-md-6 grid-margin" >
	                    			<label>활동 시작일</label>
	                    			<input type="text" readonly="readonly" name="activeStartTime" class="datepicker form-control" value="${active.activeStartDate}" placeholder="활동 시작일" >
	                    		</div>
	                    		<div class="col-md-6 grid-margin" >
	                    			<label>활동 종료일</label>
	                    			<input type="text" readonly="readonly" name="activeEndTime" class="datepicker form-control" value="${active.activeEndDate}" placeholder="활동 종료일" >
	                    		</div>
	                    		
	                   		</div>
	                      
	                    </div>
	                    
					</div>
					
					<div class="col-md-7 grid-margin" >
					
						<div class="row">
						
							<div id="map">
							    <div class="search" style="">
							        <input id="address" type="text" placeholder="검색할 주소" value="강남" />
							        <input id="submit" type="button" value="주소 검색" />
							    </div>
							</div>
						
						</div>
					
					</div>
					
					<div class="col-md-12 grid-margin">
					
						<div class="row">
	                   		
                   				<div class="col-md-6 grid-margin" >
		                   			<label>해쉬 태그</label>
		                      		<input type="hidden" name="hash" class="form-control hash" placeholder="해쉬 태그">
	                      		</div>
                      		
                   		</div>
					
						<div class="row" >
			       			<c:set var="i" value="1" ></c:set>
		           			<c:if test="${active.hashList.size() != 0}">
		           			<c:forEach var="hash" items="${active.hashList}">
		           				<div class="col-md-2 grid-margin" >
		            				<%-- <input id="hash${i}" type="text" value="#${hash.hashName}" class="form-control" > --%>
		            				<button type="button" class="btn btn-outline-warning btn-fw">#${hash.hashName}</button>
		            			</div>
		            		<c:set var="i" value="${i + 1}" ></c:set>
		           			</c:forEach>
		           			</c:if>
	           			</div>
					
					</div>
					
					<div class="col-md-12 grid-margin" >
                   		<label>활동 코멘트</label>
                   		<!-- <textarea readonly="readonly" class="form-control info" rows="10" placeholder="주의 사항이나 첨부링크를 자유롭게 작성해 주세요." ></textarea> -->
                   		<div class="row">
                   			<div class="col-lg-12 grid-margin stretch-card">
                   				<div class="card">
                   					<div class="card-body">
	                   					<div class="card-title">
	                   						
	                   						${active.activeInfo}
	                   						
	                   					</div>
                   					</div>
                   				</div>
                   			</div>
                   		</div>
                   	</div>
                   	
                   	<div class="col-md-3 grid-margin" >
                   	</div>
                   	
                   	<c:if test="${isLeader}">
	                   	<div class="col-md-5 grid-margin" >
							<div class="row">
								<div class="col-md-6 grid-margin" >
		                      		<button type="button" onclick="updateActive()" class="btn btn-success btn-lg btn-block">
			                      		수정하기
				                    </button>
				                </div>
				                <div class="col-md-6 grid-margin" >
		                      		<button type="button" onclick="deleteActive()" class="btn btn-danger btn-lg btn-block">
			                      		삭제하기
				                    </button>
				                </div>
	                      	</div>
	                      	
	                   	</div>
                   	</c:if>
                   	
                   	<c:if test="${user.role == 1}">
                   	
                   		<div class="col-md-5 grid-margin btn-area" >
                   			<button type="button" onclick="deleteActive()" style="margin-bottom: 50px;" class="btn btn-danger btn-lg btn-block">
	                      		삭제하기
		                    </button>
                   		</div>
                   	
                   	</c:if>
                   	
                   	<script type="text/javascript">
	                      	
	                  	//submit함수
	                	function updateActive() {
	                		
	                		//alert('수정');
	                		self.location = '/active/updateActive/'+${active.activeNo};
	                		
	                	}
	                  	
	                	//submit함수
	                	function deleteActive() {
	                		
	                		//alert('삭제');
	                		self.location = '/active/deleteActive/'+${active.activeNo}+'?groupNo='+${active.groupNo};
	                		
	                	}
                 	
                 	</script>
                   	
                   	<div class="col-md-3 grid-margin" >
                   	</div>
					
				</div>
				
			</form>
			
       	</div>
       	
       	<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	    
	    <script type="text/javascript">
	    	//$('footer').removeClass('fixed-bottom');
	    </script>
       	
    </div>

</body>
</html>
