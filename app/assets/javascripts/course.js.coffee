$(document).ready ->

  $(document).on 'click', '#course_author_type_user', ->
    $('#author-organization').hide()
    return

  $(document).on 'click', '#course_author_type_organization', ->
    $('#author-organization').show()
    return
  return