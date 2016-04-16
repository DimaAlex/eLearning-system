function file_input() {
    $(":file").filestyle({
        buttonName: "btn-danger",
        size: "sm",
        buttonBefore: true,
        buttonText: "&nbspChoose file"
    })
}

$(document).ready(file_input);
$(document).on('page:load', file_input);