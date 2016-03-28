# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.dropdown-toggle').dropdown()
  return

$ ->
  $('#сourse_search').typeahead
    name: "course"
    remote: "/courses/autocomplete?query=%QUERY"