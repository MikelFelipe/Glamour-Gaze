document.addEventListener('DOMContentLoaded', function() {
    const slidesContainer = document.querySelector('.slides-container');
    const prevBtn = document.querySelector('.prev-btn');
    const nextBtn = document.querySelector('.next-btn');
    const slides = document.querySelectorAll('.slides-container img');
    let index = 0;
    let slideInterval;

    function updateSlide() {
        const slideWidth = slides[0].clientWidth;
        slidesContainer.style.transform = `translateX(-${index * slideWidth}px)`;
    }

    function startAutoSlide() {
        slideInterval = setInterval(function() {
            index = (index < slides.length - 1) ? index + 1 : 0;
            updateSlide();
        }, 7000); // Change slide every 3 seconds
    }

    function stopAutoSlide() {
        clearInterval(slideInterval);
    }

    function restartAutoSlide() {
        setTimeout(function() {
            startAutoSlide();
        }, 4000); // Restart automatic sliding after 4 seconds
    }

    prevBtn.addEventListener('click', function() {
        stopAutoSlide();
        index = (index > 0) ? index - 1 : slides.length - 1;
        updateSlide();
        restartAutoSlide();
    });

    nextBtn.addEventListener('click', function() {
        stopAutoSlide();
        index = (index < slides.length - 1) ? index + 1 : 0;
        updateSlide();
        restartAutoSlide();
    });

    startAutoSlide(); // Start the automatic sliding
});

                    // HOMEPAGE ENDS



                    // ADS START
        
let slideIndex = 1;
let autoSlideInterval;

// Show initial slide and start auto sliding
showSlides(slideIndex);
startAutoSlide();

// Function to show slides
function showSlides(n) {
    const slides = document.getElementsByClassName("slide");

    // If slideIndex is greater than number of slides, go back to first slide
    if (n > slides.length) {
        slideIndex = 1;
    }

    // If slideIndex is less than 1, go to last slide
    if (n < 1) {
        slideIndex = slides.length;
    }

    // Hide all slides and remove active class
    for (let i = 0; i < slides.length; i++) {
        slides[i].classList.remove("active-slide");
    }

    // Show the current slide and add the active class
    slides[slideIndex - 1].classList.add("active-slide");
}

// Function for next/prev controls
function plusSlides(n) {
    clearInterval(autoSlideInterval); // Stop auto sliding when clicking prev/next
    showSlides(slideIndex += n);
    startAutoSlide(); // Restart auto sliding after 5 seconds
}

// Start automatic slideshow
function startAutoSlide() {
    autoSlideInterval = setInterval(() => {
        showSlides(slideIndex += 1);
    }, 5000); // Slide every 5 seconds
}

// Event listeners for prev/next buttons
document.querySelector('.prev').addEventListener('click', function () {
    plusSlides(-1);
});

document.querySelector('.next').addEventListener('click', function () {
    plusSlides(1);
});



// Get the navigation element
const navbar = document.querySelector('nav');

// Listen for scroll events
window.addEventListener('scroll', () => {
    if (window.scrollY > 0) { // Check if the page is scrolled down
        navbar.classList.add('scrolled'); // Add the scrolled class
    } else {
        navbar.classList.remove('scrolled'); // Remove the class if at the top
    }
});

                    // ADS ENDS


                    // BEST SELLER STARTS
                   // Wait for DOMContentLoaded to ensure the DOM is ready
// document.addEventListener('DOMContentLoaded', () => {
//     const track = document.querySelector('.carousel-track');
//     const prevBt = document.getElementById('prevBt');
//     const nextBt = document.getElementById('nextBt');

//     let currentIndex = 2; // Start with the 3rd item (index starts from 0)
//     const visibleItems = 5; // Number of items to show at once

//     // Update total items dynamically after content is rendered
//     function updateCarouselPosition() {
//         const items = document.querySelectorAll('.carousel-item');
//         const totalItems = items.length; // Get the total number of items after the DOM is fully loaded

//         if (totalItems === 0) return; // Do nothing if no items exist yet

//         const itemWidth = items[0].offsetWidth;  // Get the width of each item
//         const carouselContainerWidth = document.querySelector('.carousel-container').offsetWidth; // Width of the visible area

//         // Calculate how much to shift to center the focused item
//         const centerOffset = (carouselContainerWidth / 2) - (itemWidth / 2);
        
//         // Adjust the carousel's offset based on the current index
//         const offset = -(currentIndex * itemWidth) + centerOffset;

//         // Update the position of the track to scroll it
//         track.style.transform = `translateX(${offset}px)`;

//         // Optionally: Add focus to the centered item (e.g. add a class to highlight it)
//         items.forEach(item => item.classList.remove('focused')); // Remove focus from all items
//         items[currentIndex].classList.add('focused'); // Add focus to the centered item
//     }

//     // Next button functionality
//     nextBt.addEventListener('click', () => {
//         const items = document.querySelectorAll('.carousel-item');
//         const totalItems = items.length; // Get total items dynamically

//         if (currentIndex < totalItems - visibleItems) {
//             currentIndex += 1; // Move to the next item
//         }
//         updateCarouselPosition();
//     });

//     // Prev button functionality
//     prevBt.addEventListener('click', () => {
//         if (currentIndex > 0) {
//             currentIndex -= 1; // Move to the previous item
//         }
//         updateCarouselPosition();
//     });

//     // Initialize the carousel position
//     updateCarouselPosition();
// });

                    
                    // BEST SELLER ENDS


