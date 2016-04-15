var ready;
ready = function(){
    $('.chosen-select').chosen({
        no_results_text: 'No results matched'
    });
}

$(document).ready(ready);
$(document).on("page:load",ready);
