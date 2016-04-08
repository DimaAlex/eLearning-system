$ ->
  $('body').on 'click', '.pagination a', (e) ->
    e.preventDefault()
    $.getScript @href
    false
  return