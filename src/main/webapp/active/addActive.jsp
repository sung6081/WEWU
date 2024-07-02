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
<script src="/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
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
    .btn-area {
        margin-top: 20px;
    }
    .content-wrapper {
        margin-bottom: 50px;
    }
    .search { position: absolute; z-index: 1000; top: 20px; left: 20px; }
    .search #address { width: 150px; height: 20px; line-height: 20px; border: solid 1px #555; padding: 5px; font-size: 12px; box-sizing: content-box; }
    .search #searchBtn { height: 30px; line-height: 30px; padding: 0 10px; font-size: 12px; border: solid 1px #555; border-radius: 3px; cursor: pointer; box-sizing: content-box; }
    .search #searchBtn {
        background: #57B657;
        color: white;
    }
    
    .display-4 {
	  color: #fff; /* 원하는 색상으로 변경 */
	}
	
	.main-panel{
		margin:0;
	}
	
	.jumbotron{
		background-color: #00A06C;
		margin-top:160px;
		margin-bottom:0;
		background-size: contain; /* 이미지가 컨테이너 안에 맞도록 */
		background-image: url('/images/plant1.jpg'); /* 배경 이미지 경로 */
		background-size: cover; /* 이미지가 컨테이너를 덮도록 */
		background-position: center; /* 이미지가 중앙에 위치하도록 */
	}
	
	.sidebar {
		margin-top: 30px;
	}
	
</style>
</head>
<body>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<script type="text/javascript">
    $.datepicker.setDefaults({
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
        $('.datepicker').datepicker();
    });

    $(document).ready(function() {
        var location;
        var activeMarker = null;
        var map_x = 37.3595316; // 기본값으로 강남 좌표 사용
        var map_y = 127.1052133; // 기본값으로 강남 좌표 사용
        
        $(document).ready(function() {
		    var now = new Date();
		    var hours = String(now.getHours()).padStart(2, '0');
		    var minutes = String(now.getMinutes()).padStart(2, '0');
		    var localTime = hours + ':' + minutes;
		    $('.time').val(localTime);
		});

        console.log('Map X: ' + map_x);
        console.log('Map Y: ' + map_y);

        var map = new naver.maps.Map("map", {
            center: new naver.maps.LatLng(map_x, map_y),
            zoom: 15,
            mapTypeControl: true
        });

        var locationBtnHtml = '<a href="#" class="btn_mylct"><i class="mdi mdi-target"></i></a>';

        naver.maps.Event.once(map, 'init', function() {
            var $locationBtn = $(locationBtnHtml),
                locationBtnEl = $locationBtn[0];

            map.controls[naver.maps.Position.RIGHT_BOTTOM].push(locationBtnEl);

            naver.maps.Event.addDOMListener(locationBtnEl, 'click', function(e) {
                e.preventDefault(); // 기본 동작 방지
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
                } else {
                    alert('Geolocation is not supported by this browser.');
                }
            });
        });

        function onSuccessGeolocation(position) {
            var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);
            map.setCenter(location);
            map.setZoom(15);

            /* if (activeMarker) {
                activeMarker.setMap(null);
            }

            activeMarker = new naver.maps.Marker({
                position: location,
                map: map
            }); */

            $('.activeX').val(location.lat());
            $('.activeY').val(location.lng());
        }

        function onErrorGeolocation() {
            alert('Geolocation failed!');
        }

        map.addListener('click', function(e) {
            var latlng = e.coord;
            if (activeMarker) {
                activeMarker.setMap(null);
            }
            activeMarker = new naver.maps.Marker({
                position: latlng,
                map: map,
                icon: {
			        url: 'https://cdn-icons-png.freepik.com/512/297/297362.png?ga=GA1.1.1709417345.1719880420',
			        size: new naver.maps.Size(50, 50), // 원래 이미지 크기
			        scaledSize: new naver.maps.Size(50, 50), // 조정된 이미지 크기
			        origin: new naver.maps.Point(0, 0), // 이미지의 원점
			        anchor: new naver.maps.Point(25, 50) // 마커 이미지의 앵커 포인트
			    }
            });

            $('.activeX').val(latlng.lat());
            $('.activeY').val(latlng.lng());
        });

        function searchAddressToCoordinate(address) {
            var url = '/app/active/searchLocal?query=' + address;
            $.ajax({
                url: url,
                method: 'GET',
                success: function(response) {
                    naver.maps.Service.geocode({
                        query: response.address
                    }, function(status, response) {
                        if (status === naver.maps.Service.Status.OK) {
                            var item = response.v2.addresses[0];
                            var point = new naver.maps.Point(item.x, item.y);
                            map.setCenter(point);
                            /* if (activeMarker) {
                                activeMarker.setMap(null);
                            }
                            activeMarker = new naver.maps.Marker({
                                position: point,
                                map: map
                            }); */

                            $('.activeX').val(point.y);
                            $('.activeY').val(point.x);
                        }
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Failed to fetch address:', error);
                }
            });
        }

        $('#address').on('keydown', function(e) {
            if (e.which === 13) {
                e.preventDefault();
                searchAddressToCoordinate($('#address').val());
            }
        });

        $('#searchBtn').on('click', function(e) {
            e.preventDefault();
            searchAddressToCoordinate($('#address').val());
        });
    });
</script>

<div class="jumbotron">
  <div class="container">
    <p class="display-4"><b>addActive</b></p>
  </div>
</div>

<!-- SIDE -->
<jsp:include page="/group/groupSide.jsp"></jsp:include>
<!-- SIDE -->

<div class="main-panel">
    <div class="content-wrapper">
        <form class="addForm" id="addForm" encType="multipart/form-data">
            <div class="row">
                <div class="col-md-12 grid-margin">
                    <h4>활동 등록하기</h4>
                </div>
                <div class="col-md-5 grid-margin">
                    <div class="row">
                        <div class="col-md-6 grid-margin">
                            <div class="form-group">
                                <label>활동 이름</label>
                                <input type="text" name="activeName" class="form-control" placeholder="활동 이름">
                                <input type="hidden" name="groupNo" value="${groupNo}">
                                <input type="hidden" class="activeLocal" name="activeLocal">
                                <input type="hidden" class="activeX" name="activeX">
                                <input type="hidden" class="activeY" name="activeY">
                            </div>
                        </div>
                        <div class="col-md-5 grid-margin">
                            <div class="form-group">
                                <label>그룹장 닉네임</label>
                                <input type="text" name="leaderNick" disabled="disabled" class="form-control" value="${group.leaderNick}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>모임시간</label>
                        <div class="row">
                            <div class="col-md-5 grid-margin">
                                <input type="time" name="activeStartTime" class="time form-control">
                            </div>
                            <div class="col-md-1 grid-margin">
                            </div>
                            <div class="col-md-5 grid-margin">
                                <input type="time" name="activeEndTime" class="time form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 grid-margin">
                                <label>활동 시작일</label>
                                <input type="text" name="activeStartDate" class="datepicker form-control" placeholder="활동 시작일">
                            </div>
                            <div class="col-md-6 grid-margin">
                                <label>활동 종료일</label>
                                <input type="text" name="activeEndDate" class="datepicker form-control" placeholder="활동 종료일">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7 grid-margin">
                    <div class="row">
                        <div id="map">
                            <div class="search">
                                <input id="address" type="text" placeholder="검색할 주소">
                                <input id="searchBtn" type="button" value="주소 검색">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <button type="button" onclick="upload()" class="upload-btn btn btn-outline-success btn-icon-text">
                            <i class="ti-upload btn-icon-prepend"></i>                                                    
                            마커 사진 upload
                        </button>
                        <input class="file" type="file" hidden="true" name="file" accept=".jpg,.jpeg,.png,.gif">
                    </div>
                    <script type="text/javascript">
                        function upload() {
                            $('.file').click();
                        }
                        $('.file').on('change', function() {
                            if ($('.file').val()) {
                                $('.upload-btn').html('<i class="ti-upload btn-icon-prepend"></i>' + $('.file').val());
                            } else {
                                $('.upload-btn').html('마커 사진 upload');
                            }
                        });
                    </script>
                </div>
                <div class="col-md-12 grid-margin">
                    <div class="row">
                        <div class="col-md-6 grid-margin">
                            <label>해쉬 태그</label>
                            <input type="hidden" name="hash" class="form-control hash" placeholder="해쉬 태그">
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach begin="1" end="5" var="i">
                            <div class="col-md-2 grid-margin">
                                <input id="hash${i}" type="text" class="form-control">
                            </div>
                        </c:forEach>
                    </div>
                    <div class="row">
                        <label>활동 코멘트</label>
                        <textarea class="form-control" id="activeInfo" name="activeInfo" placeholder="주의 사항이나 첨부링크를 자유롭게 작성해 주세요." style="width:100%;"></textarea>
                        <script type="text/javascript">
                            var oEditors = [];
                            nhn.husky.EZCreator.createInIFrame({
                                oAppRef: oEditors,
                                elPlaceHolder: "activeInfo",
                                sSkinURI: "/editor/SmartEditor2Skin.html",
                                fCreator: "createSEditor2"
                            });
                        </script>
                    </div>
                    <div class="row btn-area">
                        <button type="button" onclick="addActive()" class="btn btn-success btn-lg btn-block">
                            등록하기
                        </button>
                    </div>
                    <script type="text/javascript">
                        function addActive() {
                            var hashString = '';
                            if ($('.activeName').val() == '') {
                                alert('활동 이름을 입력해 주세요.');
                                return;
                            }
                            if ($('.activeX').val() == '' || $('.activeY').val() == '') {
                                alert('활동 마커를 지도에 찍어주세요.');
                                return;
                            }
                            if ($('.activeStartDate').val() == '' || $('.activeEndDate').val() == '') {
                                alert('활동 기간을 입력해 주세요.');
                                return;
                            }
                            for (let i = 1; i <= 5; i++) {
                                if ($('#hash' + i).val()) {
                                    hashString += (hashString ? ',' : '') + $('#hash' + i).val();
                                }
                            }
                            oEditors.getById["activeInfo"].exec("UPDATE_CONTENTS_FIELD", []);
                            $('.hash').val(hashString);
                            $('#addForm').attr('method', 'post');
                            $('#addForm').attr('action', '/active/addActive');
                            $('#addForm')[0].submit();
                        }
                    </script>
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
