<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map</title>
<style>
    .btn_mylct i {
        font-size: 50px; /* 아이콘 크기를 키웁니다 */
    }
    .info-panel {
        margin-top: 10px;
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 5px;
    }
    .info-row td {
        padding: 0 !important;
        border-top: none !important;
    }
    .info-button {
        position: absolute;
        bottom: 10px;
        right: 10px;
    }
    .mdi-target {
        color: #57B657;
    }
    .search { position: absolute; z-index: 1000; top: 20px; left: 20px; }
    .search #address { width: 150px; height: 20px; line-height: 20px; border: solid 1px #555; padding: 5px; font-size: 12px; box-sizing: content-box; }
    .search #submit { height: 30px; line-height: 30px; padding: 0 10px; font-size: 12px; border: solid 1px #555; border-radius: 3px; cursor: pointer; box-sizing: content-box; }
    .search #submit {
        background: #57B657;
        color: white;
    }
</style>
<link rel="stylesheet" href="/vendors/mdi/css/materialdesignicons.min.css">
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${clientId}&submodules=panorama,geocoder"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

    $(document).ready(function() {
        var location;
        var selfMarker = null;
        var infowindow = new naver.maps.InfoWindow();
        
        if('${activeListString}' != '') {
            activeListString = JSON.parse('${activeListString}');
        } else {
            activeListString = [];
        }
        
        var height = $(window).height() - 300;
        $('#map').height(300);
        
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
        } else {
            var center = map.getCenter();
        }
        
        function onSuccessGeolocation(position) {
            location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);
            
            if (selfMarker) {
                selfMarker.setMap(null);
            }
            
            selfMarker = new naver.maps.Marker({
                position: location,
                map: map
            });

            map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
            map.setZoom(15); // 지도의 줌 레벨을 변경합니다.
            $('#address').val('');
            console.log('Coordinates: ' + location.toString());
        }

        function onErrorGeolocation() {
            var center = map.getCenter();
        }

        var map = new naver.maps.Map("map", {
            center: new naver.maps.LatLng(37.3595316, 127.1052133),
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

        async function searchAddressToCoordinate(address) {
            var searchCondition = $('#condition').val();

            if (searchCondition == 'active') {
                var url = '/app/active/listActive';

                await $.ajax({
                    url: url,
                    method: 'POST',
                    data: JSON.stringify({ searchKeyword: address }),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function(res) {
                        activeListString = res;

                        for (let i = 0; i < activeMarkers.length; i++) {
                            activeMarkers[i].setMap(null);
                        }

                        activeMarkers = [];

                        for (let i = 0; i < activeListString.length; i++) {
                            let markerOptions = null;

                            if (activeListString[i].activeShortUrl != null) {
                                markerOptions = {
                                    position: new naver.maps.LatLng(activeListString[i].activeX, activeListString[i].activeY),
                                    map: map,
                                    icon: {
                                        url: activeListString[i].activeShortUrl,
                                        size: new naver.maps.Size(50, 50),
                                        scaledSize: new naver.maps.Size(50, 50),
                                        origin: new naver.maps.Point(0, 0),
                                        anchor: new naver.maps.Point(25, 50)
                                    }
                                };
                            } else {
                                markerOptions = {
                                    position: new naver.maps.LatLng(activeListString[i].activeX, activeListString[i].activeY),
                                    map: map,
                                    icon: {
                                        url: '/images/icon/sp_pin_hd.png',
                                        size: new naver.maps.Size(26, 36),
                                        origin: new naver.maps.Point(1, 1),
                                        anchor: new naver.maps.Point(13, 36),
                                        scaledSize: new naver.maps.Size(395, 79)
                                    }
                                };
                            }

                            let activeMarker = new naver.maps.Marker(markerOptions);
                            activeMarkers.push(activeMarker);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Failed to fetch server list:', error);
                    }
                });

                return;
            }

            var url = '/app/active/searchLocal?query=' + address;
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
                if (status === naver.maps.Service.Status.ERROR) {
                    return alert('Something Wrong!');
                }

                if (response.v2.meta.totalCount === 0) {
                    return alert('totalCount' + response.v2.meta.totalCount);
                }

                var item = response.v2.addresses[0];
                var point = new naver.maps.Point(item.x, item.y);
                map.setCenter(point);
            });
        }

        function initGeocoder() {
            $('#address').on('keydown', function(e) {
                if (e.which === 13) {
                    e.preventDefault();
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

        naver.maps.onJSContentLoaded = initGeocoder;

        activeMarkers = [];

        for (let i = 0; i < activeListString.length; i++) {
            let markerOptions = null;

            if (activeListString[i].activeShortUrl != null) {
                markerOptions = {
                    position: new naver.maps.LatLng(activeListString[i].activeX, activeListString[i].activeY),
                    map: map,
                    icon: {
                        url: activeListString[i].activeShortUrl,
                        size: new naver.maps.Size(50, 50),
                        scaledSize: new naver.maps.Size(50, 50),
                        origin: new naver.maps.Point(0, 0),
                        anchor: new naver.maps.Point(25, 50)
                    }
                };
            } else {
                markerOptions = {
                    position: new naver.maps.LatLng(activeListString[i].activeX, activeListString[i].activeY),
                    map: map,
                    icon: {
                        url: '/images/icon/sp_pin_hd.png',
                        size: new naver.maps.Size(26, 36),
                        origin: new naver.maps.Point(1, 1),
                        anchor: new naver.maps.Point(13, 36),
                        scaledSize: new naver.maps.Size(395, 79)
                    }
                };
            }

            let activeMarker = new naver.maps.Marker(markerOptions);
            activeMarkers.push(activeMarker);
        }
    });
</script>
</head>
<body>

<div id="map">
    <div class="search">
        <input id="address" type="text" placeholder="검색할 주소" value="강남">
        <input id="submit" type="button" value="주소 검색">
    </div>
</div>

</body>
</html>
