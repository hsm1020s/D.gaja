let slideIndex = 0;
let slideIndexItem = 0;
showSlides();
showItemList();

// 4개씩 나오는 슬라이드
function showItemList() {
    let j;
    let slidesAll = document.getElementsByClassName("responsive");
    for (j = 0; j < slidesAll.length; j++) {
        slidesAll[j].style.display = "none";
    }
    for (let i = 0; i < 4; i++) {
        if (slideIndexItem >= slidesAll.length) {
            slideIndexItem = 0;
        }

        // Display the slide
        slidesAll[slideIndexItem].style.display = "block";
        slideIndexItem++;
    }
    setTimeout(showItemList, 2000);
}

// 메인 슬라이드
function showSlides() {
    let i;
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > slides.length) {
        slideIndex = 1
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";
    setTimeout(showSlides, 4000); // Change image every 2 seconds
}

// dot 누르면 작동하는 코드
function currentSlide(n) {
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");
    let slideIndex;

    if (n > slides.length) {
        slideIndex = 1
    } else if (n < 1) {
        slideIndex = slides.length
    } else {
        slideIndex = n;
    }

    for (let i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (let i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }

    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";
}

var buttons = {
    animal: document.getElementById('animal-button'),
    nature: document.getElementById('nature-button'),
    food: document.getElementById('food-button'),
    pro: document.getElementById('pro-button'),
};

var images = {
    animal: document.getElementById('animal-images'),
    nature: document.getElementById('nature-images'),
    food: document.getElementById('food-images'),
    pro: document.getElementById('pro-images'),
};

// 처음 로드 될 때 모든 이미지를 숨깁니다.
for (var imgKey in images) {
    images[imgKey].style.display = 'none';
}
// 처음 로드 될 때 'animal'에 해당하는 이미지만 보여줍니다.
images['animal'].style.display = 'grid';

for (var key in buttons) {
    (function (key) {
        buttons[key].addEventListener('click', function () {
            // 모든 이미지 컨테이너를 먼저 숨깁니다.
            for (var imgKey in images) {
                images[imgKey].style.display = 'none';
            }
            // 클릭한 요소에 해당하는 이미지 컨테이너만 보여줍니다.
            var imageContainer = document.getElementById(key + '-images');
            imageContainer.style.display = 'grid';
        });
    })(key);
}

// 카테고리 누르면 아래로 스크롤 모션
$('a[href^="#"]').on('click', function(event) {
    var target = $(this.getAttribute('href'));
    if (target.length) {
        event.preventDefault();
        $('html, body').stop().animate({
            scrollTop: target.offset().top
        }, 500); // 여기서 500은 애니메이션 지속 시간으로 1초를 의미합니다.
    }
});