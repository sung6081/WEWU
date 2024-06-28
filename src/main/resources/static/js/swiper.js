        $(document).ready(function () {
            sendAjaxRequest("/app/group/getGroupRankingList", "Ranking", "", "groupRanking");

            // 일반 Swiper 초기화
            var mySwiper = new Swiper('.swiper-container:not(.ranking)', {
                slidesPerView: 4,
                slidesPerGroup: 1,
                loop: true,
                observer: true,
                observeParents: true,
                spaceBetween: 24,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                breakpoints: {
                    1280: {
                        slidesPerView: 3,
                        slidesPerGroup: 3,
                    },
                    720: {
                        slidesPerView: 1,
                        slidesPerGroup: 1,
                    }
                }
            });

            function sendAjaxRequest(url, searchCondition, searchKeyword, targetElementId) {
                $.ajax({
                    url: url,
                    type: "POST",
                    async: true,
                    cache: true,
                    timeout: 3000,
                    data: JSON.stringify({
                        searchCondition: searchCondition,
                        searchKeyword: searchKeyword,
                        pageSize: 0
                    }),
                    processData: true,
                    contentType: "application/json",
                    dataType: "json",
                    beforeSend: function () {
                        // AJAX 요청 전에 실행되는 함수
                    },
                    success: function (data, status, xhr) {
                        // AJAX 요청 성공 시 실행되는 함수
                        var str = "";

                        for (var i = 0; i < data.length; i++) {
                            str += "<div class='swiper-slide ranking'>" + data[i].groupName + "</div>";
                        }

                        $('.' + targetElementId).html(str);

                        // ranking Swiper 초기화
                        var rankingSwiper = new Swiper('.swiper-container.ranking', {
                            direction: 'vertical', // direction: 'vertical'로 변경할 수 있습니다.
                            autoplay: {
                                delay: 3000, // 자동 재생 지연 시간 (밀리초)
                            },
                            loop: true,
                            navigation: {
                                nextEl: '.swiper-button-next',
                                prevEl: '.swiper-button-prev'
                            }
                        });

                        rankingSwiper.update(); // Swiper 업데이트
                    },
                    error: function (xhr, status, error) {
                        // AJAX 요청 실패 시 실행되는 함수
                    },
                    complete: function (xhr, status) {
                        // AJAX 요청 완료 후 실행되는 함수
                    }
                });
            }
        });