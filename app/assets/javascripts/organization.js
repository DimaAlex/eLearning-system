function by_email() {
    $('#by_email').slideDown();
    $('#from_file').slideUp();
}

function from_file() {
    $('#by_email').slideUp();
    $('#from_file').slideDown();
}

function form_hide() {
    $('#by_email').hide();
    $('#from_file').hide();
}

function form_slideUp() {
    $('#by_email').slideUp();
    $('#from_file').slideUp();
}

$(document).ready(form_hide);
$(document).on('page:load', form_hide);
