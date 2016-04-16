course_create = ->

  $(document).on 'click', '#course_permission_in_organization', ->
    $('#author-type').hide()
    return

  $(document).on 'click', '#course_author_type_user', ->
    $('#author-organization').hide()
    return

  $(document).on 'click', '#course_author_type_organization', ->
    $('#author-organization').show()
    return
  return

$(document).ready course_create
$(document).on 'page:load', course_create