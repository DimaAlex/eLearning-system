ajax_method = ->
  $('body').on 'click', '.pagination a', (e) ->
    e.preventDefault()
    $.getScript @href
    false
  return
$(document).ready ajax_method
$(document).on 'page:load', ajax_method