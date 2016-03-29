function choise_recipients(){
  $('#recipient_email').change(function(){
    $.ajax({
        url: '/conversations/get_recipients',
        datatype: 'json',
        method: 'GET'
    }).success(function(data){
      $('.chosen-select').empty();
      var content = '';
      data.forEach(function(item, i, arr) {
          content = '<option>'+item["email"]+'</option>';
          $('.chosen-select').append(content);
      });
      $('.chosen-select').trigger("chosen:updated");
    });
  });
  $('#recipient_last_name').change(function(){
    $.ajax({
        url: '/conversations/get_recipients',
        datatype: 'json',
        method: 'GET'
    }).success(function(data){
      $('.chosen-select').empty();
      var content = '';
      data.forEach(function(item, i, arr) {
          content = '<option>'+item["last_name"]+'</option>';
          $('.chosen-select').append(content);
      });
      $('.chosen-select').trigger("chosen:updated");
    });
  });

};
$(document).ready(choise_recipients)
$(document).on('page:load', choise_recipients)

