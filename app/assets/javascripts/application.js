//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require DataTables
//= require materialize-sprockets
//= require_tree ./templates
//= require underscore
//= require select2
//= require_tree .

$(document).on("turbolinks:load", function(){
  $('#employee_id').select2()
  var picker = $('#entry_expired_at').pickadate({
    monthsFull: [ 'января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря' ],
    monthsShort: [ 'янв', 'фев', 'мар', 'апр', 'май', 'июн', 'июл', 'авг', 'сен', 'окт', 'ноя', 'дек' ],
    weekdaysFull: [ 'воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота' ],
    weekdaysShort: [ 'вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'сб' ],
    today: 'сегодня',
    clear: '',
    close: 'закрыть',
    firstDay: 1,
    format: 'dd.mm.yyyy',
    formatSubmit: 'dd/mm/yyyy',
    hiddenName: true,
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15,
    onClose: function() {
      $(document.activeElement).blur()
    },

  });
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

  var entries_table = $('#entries_table').DataTable({
    columnDefs: [{
          targets: 1,
          render: $.fn.dataTable.render.ellipsis( 20 )
    }],
    fixedColumns: true,
    paging: false,
    // searching: false,
    info:     false,
    // ordering: false,
    "ajax": {
      "dataSrc": "",
      url: '/entries.json?archive=false'
    },
    columns: [
      { data: 'id' },
      { data: 'document', 'sWidth': '10%'  },
      { data: 'employee' },
      { data: 'created_at' },
      { data: 'expired_at' },
      { data: 'closed' },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Продлить' data-remote='true' rel='nofollow' data-method='post' href='/entries/extend?entry_id="+oData.id+"'><i class='material-icons'>schedule</i></a>");
        }
      },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Оповестить' data-remote='true' rel='nofollow' data-method='post' href='"+oData.url+"/notify'><i class='material-icons'>notifications</i></a>");
        }
      },
      { data: 'id',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Редактировать' href='"+oData.url+"/edit'><i class='material-icons'>edit</i></a>");
        }
      },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Удалить' data-confirm='Точно удалить?' data-remote='true' rel='nofollow' data-method='delete' href='"+oData.url+"'><i class='material-icons'>delete</i></a>");
        }
      }
    ]
  });


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

  $('#documents_form').on("keypress",".documents_code input", function(event){
    if (event.which == 13){
      event.preventDefault();
      return false;
    }
  })
  // $('#documents_form').keydown(function(event){
  //   if(event.keyCode == 13) {
  //     event.preventDefault();
  //     return false;
  //   }
  // });

  Materialize.updateTextFields();
  $('.modal').modal();
})

