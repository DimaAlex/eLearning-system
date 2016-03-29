$ ->
  $('.radio_type input[type="checkbox"]').bind 'click', ->
    $('.radio_type input[type="checkbox"]').not(this).prop 'checked', false
    return
  return