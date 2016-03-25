$(document).ready(function(){
  $('input[type=radio][name=recipient]').change(function() {
    if (this.value == 'email') {
      alert("EMAIL");
    }
    else if (this.value == 'last_name') {
      alert("LAST_NAME");
    }

    // $.ajax({
    //     url: 'mycontr/get_users',
    //     method: 'GET',
    //     datatype: 'json'
    //   }).success(functio(data){

    //     $.each(data, function(value,key) {
    //       $("#id").append($("<option></option>")
    //          .attr("value", value).text(key));
    //     });

    //   })
  });

  // $("#2").change(function(){
  //   alert("2234");
  });



//render :json {data[email] }
