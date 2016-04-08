# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

home_page = ->
  $('#finished-courses').hide()
  $('#liked-courses').hide()


  $('.carousel').carousel({
    interval: 3000
    })

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

