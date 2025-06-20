// scripts.js
let lastScrollTop = 0;
const navbar = document.getElementById('navbar');

window.addEventListener('scroll', function() {
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    if (scrollTop > lastScrollTop) {
        navbar.classList.add('navbar-hidden');
    } else {
        navbar.classList.remove('navbar-hidden');
    }
    lastScrollTop = scrollTop;
});


document.addEventListener('DOMContentLoaded', function() {
    const cookieConsent = document.getElementById('cookieConsent');
    const acceptCookiesButton = document.getElementById('acceptCookies');

    // Mostrar el banner de cookies si no está aceptado
    if (!localStorage.getItem('cookiesAccepted')) {
        cookieConsent.style.display = 'block';
    }

    // Aceptar cookies
    acceptCookiesButton.addEventListener('click', function() {
        localStorage.setItem('cookiesAccepted', 'true');
        cookieConsent.style.display = 'none';
    });
});