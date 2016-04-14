pages = ->
  $('#question').hide()

  $(document).on 'click', '#page_page_type_lecture', ->
    $('#question').hide()
    return

  $(document).on 'click', '#page_page_type_video', ->
    $('#question').hide()
    return
  $(document).on 'click', '#page_page_type_question', ->
    $('#question').show()
    $('#count-of-answers').hide()
    return
  $(document).on 'click', '#page_answers_attributes_0_answer_type_input', ->
    $('#count-of-answers').hide()
    return
  $(document).on 'click', '#page_answers_attributes_0_answer_type_radio', ->
    $('#count-of-answers').show()
    return
  $(document).on 'click', '#page_answers_attributes_0_answer_type_checkbox', ->
    $('#count-of-answers').show()
    return
  return

$(document).ready pages
$(document).on 'page:load', pages