autocom = ->
  $('#org_search').typeahead
    name: "organization"
    remote: "/organizations/autocomplete?query=%QUERY"

$(document).ready(autocom);
$(document).on('page:load', autocom);
