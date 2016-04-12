// var bloodhound = new Bloodhound({
//   datumTokenizer: function (d) {
//     return Bloodhound.tokenizers.whitespace(d.value);
//   },
//   queryTokenizer: Bloodhound.tokenizers.whitespace,

//   // sends ajax request to /typeahead/%QUERY
//   // where %QUERY is user input
//   remote: '/typeahead/%QUERY',
//   limit: 50
// });
// bloodhound.initialize();

// // initialize typeahead widget and hook it up to bloodhound engine
// // #typeahead is just a text input
// $('#typeahead').typeahead(null, {
//   displayKey: 'name',
//   source: bloodhound.ttAdapter()
// });

// // this is the event that is fired when a user clicks on a suggestion
// $('#typeahead').bind('typeahead:selected', function(event, datum, name) {
//   doSomething(datum.id);
// });
var ready;
ready = function() {
    var engine = new Bloodhound({
      remote: {url: "/courses/autocomplete?query=%QUERY"},
      datumTokenizer: function(d) {
        return Bloodhound.tokenizers.whitespace(d.title); },
      queryTokenizer: Bloodhound.tokenizers.whitespace
    });

    var promise = engine.initialize();

    promise
    .done(function() { console.log('success!')})
    .fail(function() { console.log('err!')});

    $('.typeahead').typeahead(null, {
        displayKey: 'title',
        source: engine.ttAdapter()
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
