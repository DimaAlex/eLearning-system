# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('body').on 'click', '#page_type , #pages list-group, #page_form list-group' , (e) ->
    e.preventDefault()
    $.getScript @href
    false
  return
