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

$(document).ready(form_hide);
$(document).on('page:load', form_hide);
