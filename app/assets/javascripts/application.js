// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .
$(document).ready(function(){
  $.fn.serializeObject = function() {
    var values = {}
    $("form input, form select, form textarea").each( function(){
      values[this.name] = $(this).val();
    });
    return values;
  }
      
  function clear_errors() {
    $('#js-error-block ul').html('');
    $('.form-control').attr('style','1px solid #ccc;');
  }
  
  String.prototype.titleize = function() {
    return this.replace(/(?:^|\s)\S/g, function(a) { return a.toUpperCase(); });
  };

  $("form#ajax_signin").submit(function(e){
    e.preventDefault();
    var email = $('#user_email').val();
    var password = $('#user_password').val();
    var remember_me = ($('#user_remember_me:checked').length != 0) ? 1 : 0;
    var token = document.querySelector('meta[name="csrf-token"]').content
    $.ajax({
      type: "POST",
      url: "http://localhost:3000/users/sign_in.json",
      contentType: "application/json",
      dataType: 'json',
      headers: {
        'X-CSRF-Token': token
      },
      data: JSON.stringify({"user":{"email": email, "password": password, "remember_me": remember_me}}),
      success: function(json){
        console.log("success");
        location.href = "/";;
      },
      error: function(xhr) { 
        // error_messages =  messages.titleize() + ' ' + errors[messages];
        // var field = "form#ajax_signup " + "#user_" + messages;
        // var error_message = error_messages;
        console.log("error_messages");
        // //alert(error_messages);
        // $('#js-error-block-login ul').append("<li>"+error_messages+"</li>");
        // $(field).css('border', '1px solid #D9534F'); 
      }, 
      dataType: "json"
    });
  });
      
  $("form#ajax_signup").submit(function(e){
    e.preventDefault(); 
    var user_info = $(this).serializeObject();
    $.ajax({
      type: "POST",
      url: "http://localhost:3000/users",
      data: user_info,
      success: function(json){
        location.href = "/";;
      },
      error: function(xhr) {
        var errors = jQuery.parseJSON(xhr.responseText).errors; 
        for (messages in errors) { 
          error_messages =  messages.titleize() + ' ' + errors[messages];
          var field = "form#ajax_signup " + "#user_" + messages;
          var error_message = error_messages;
          console.log(error_messages);
          //alert(error_messages);
          $('#js-error-block-signup ul').append("<li>"+error_messages+"</li>");
          $(field).css('border', '1px solid #D9534F');          
        } 
        $('#js-error-block-signup').show();
       }, 
       dataType: "json"
     });
     clear_errors();
  });
});