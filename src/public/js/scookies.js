$(document).ready(function () {
    if (localStorage.getItem('cookiesAccepted') === 'true') {
        $('#cookieConsent').remove();
    }

    $('#acceptCookies').click(function () {
        $('#cookieConsent').fadeOut(400, function () {
            $(this).remove();
        });
        localStorage.setItem('cookiesAccepted', 'true');
    });
});