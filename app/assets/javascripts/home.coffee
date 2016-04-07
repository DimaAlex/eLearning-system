# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

home_page = ->
  $('#finished-courses').hide()

  $('.carousel').carousel({
    interval: 3000
    })

  $(document).on 'click', '#current_courses_button', ->
    $('#finished-courses').hide()
    $('#current-courses').show()
    return

  $(document).on 'click', '#finished_courses_button', ->
    $('#finished-courses').show()
    $('#current-courses').hide()
    return

  $('.dropdown-toggle').dropdown()
  return

  $ ->
    $('#course_search').typeahead
      name: "course"
      remote: "/courses/autocomplete?query=%QUERY"

$(document).ready home_page
$(document).on 'page:load', home_page

