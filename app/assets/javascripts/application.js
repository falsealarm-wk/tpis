//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets

//= require_tree ./templates
//= require underscore
//= require select2
//= require_tree .

$(document).on("turbolinks:load", function(){
  // window.materializeForm.init()
  $('#documents_form').on("keypress",".documents_barcode input", function(event){
    if (event.which == 13){
      event.preventDefault();
      $(".add_document_link").click()
      // var nextInputs = $(".documents_code input, .documents_barcode input")
      // console.log(nextInputs.index(this))
      // var nextInput = nextInputs.get(nextInputs.index(this) + 1);
      //   console.log(nextInput)
      // if (nextInput) {
      //   nextInput.focus
      // }
    }
  })


  // var typingTimer;                //timer identifier
  // var doneTypingInterval = 5000;  //time in ms (5 seconds)
  // var codeInput;
  // //on keyup, start the countdown
  // $('.documents').on("keyup", "input[name='documents[][code]']", function(event){
  //   var codeInput = $("input[name='documents[][code]']")
  //   var id = codeInput.index(event.target)
  //   console.log(id)
  //   showPreloader();
  //   clearTimeout(typingTimer);
  //   var text = codeInput.val()
  //   if (text) {
  //     typingTimer = setTimeout(function() {
  //       ajaxCall(text, id)
  //     }, doneTypingInterval);
  //   }
  // })
  // $("input[name='documents[][code]']").keyup(function(){
  //     showPreloader();
  //     clearTimeout(typingTimer);
  //     var text = $(this).val()
  //     if (text) {
  //       typingTimer = setTimeout(function() {
  //         ajaxCall(text)
  //       }, doneTypingInterval);
  //     }
  // });

  //user is "finished typing," do something
  function showPreloader() {
    $(".preloader").html(JST['templates/preloader'])
  }

  function removePreloader() {
    $(".preloader").html(" ")
  }
  function ajaxCall(text, id) {
    console.log(text)
    $.ajax({
      url: "/documents/find",
      contentType: 'javascript',
      data: {
        code: text,
        id: id
      },
      success: removePreloader
    })
  }
})

