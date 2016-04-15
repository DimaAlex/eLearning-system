home_page = ->
  $('#finished-courses').hide()
  $('#liked-courses').hide()

  $(document).on 'change', '#current_courses_button', ->
    $('#finished-courses').hide()
    $('#current-courses').show()
    $('#liked-courses').hide()
    return

  $(document).on 'change', '#finished_courses_button', ->
    $('#finished-courses').show()
    $('#current-courses').hide()
    $('#liked-courses').hide()
    return
  $(document).on 'change', '#liked_courses_button', ->
    $('#finished-courses').hide()
    $('#current-courses').hide()
    $('#liked-courses').show()
    return

  $('.dropdown-toggle').dropdown()
  return

  $ ->
    $('#course_search').typeahead
      name: "course"
      remote: "/courses/autocomplete?query=%QUERY"

$(document).ready home_page
$(document).on 'page:load', home_page

