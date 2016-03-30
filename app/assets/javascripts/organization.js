function by_email() {
    $('#by_email').slideDown();
    $('#from_file').slideUp();
}

function from_file() {
    $('#by_email').slideUp();
    $('#from_file').slideDown();
}

$( document ).ready(function() {
    $('#by_email').hide();
    $('#from_file').hide();
});