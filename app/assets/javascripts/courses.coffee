autocom = ->
  $('#course_search').typeahead
    name: "course"
    remote: "/courses/autocomplete?query=%QUERY"

$(document).ready(autocom);
$(document).on('page:load', autocom);
