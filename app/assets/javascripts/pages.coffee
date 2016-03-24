# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#video').hide()
  $('#question').hide()

  $(document).on 'click', '#page_page_type_lecture', ->
    $('#lecture').show()
    $('#video').hide()
    $('#question').hide()
    return

  $(document).on 'click', '#page_page_type_video', ->
    $('#video').show()
    $('#lecture').hide()
    $('#question').hide()
    return
  $(document).on 'click', '#page_page_type_question', ->
    $('#question').show()
    $('#lecture').hide()
    $('#video').hide()
    return
  return
