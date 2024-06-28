document.addEventListener("DOMContentLoaded", function() {
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
});