//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require best_in_place
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

  function getParameterByName(name, url) {
      if (!url) url = window.location.href;
      name = name.replace(/[\[\]]/g, "\\$&");
      var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
          results = regex.exec(url);
      if (!results) return null;
      if (!results[2]) return '';
      return decodeURIComponent(results[2].replace(/\+/g, " "));
  }

  var isArchive = getParameterByName('archive');
  var entries_table = $('#entries_table').DataTable({
    columnDefs: [{
          targets: 1,
          render: $.fn.dataTable.render.ellipsis( 20 )
    }],
    fixedColumns: true,
    scrollY:        '50vh',
    scrollCollapse: true,
    paging: false,
    // searching: false,
    info:     false,
    // ordering: false,
    "ajax": {
      "dataSrc": "",
      url: '/entries.json?archive='+isArchive
    },
    "language": {
                  "url": "assets/dataTables.russian.lang"
    },
    columns: [
      { data: 'id' },
      { data: 'document' },
      { data: 'employee' },
      { data: 'created_at' },
      { data: 'expired_at' },
      { data: 'closed' },
      { data: 'id',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Продлить' data-remote='true' rel='nofollow' data-method='post' href='/entries/extend?entry_id="+oData.id+"&archive="+isArchive+"'><i class='material-icons'>schedule</i></a>");
        }
      },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Оповестить' data-remote='true' rel='nofollow' data-method='post' href='"+oData.url+"/notify'><i class='material-icons'>notifications</i></a>");
        }
      },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Редактировать' href='"+oData.url+"/edit?archive="+isArchive+"'><i class='material-icons'>edit</i></a>");
        }
      },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Удалить' data-confirm='Точно удалить?' data-remote='true' rel='nofollow' data-method='delete' href='"+oData.url+"?archive="+isArchive+"'><i class='material-icons'>delete</i></a>");
        }
      }
    ]
  });

  var employees_table = $('#employees_table').DataTable({
    fixedColumns: true,
    scrollY:        '50vh',
    scrollCollapse: true,
    paging: false,
    info:     false,
    "ajax": {
      "dataSrc": "",
      url: '/employees.json'
    },
    "language": {
                  "url": "assets/dataTables.russian.lang"
    },
    columns: [
      { data: 'name' },
      { data: 'uuid' },
      { data: 'department' },
      { data: 'email' },
      { data: 'phone' },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Оповестить' data-remote='true' rel='nofollow' href='"+oData.url+"/entries'><i class='material-icons'>list</i></a>");
        }
      },
      { data: 'url',
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

  var documents_table = $('#documents_table').DataTable({
    columnDefs: [{
          targets: 1,
          render: $.fn.dataTable.render.ellipsis( 20 )
    }],
    fixedColumns: true,
    scrollY:        '50vh',
    scrollCollapse: true,
    // paging: false,
    "pageLength": 100,
    info:     false,
    "ajax": {
      "dataSrc": "",
      url: '/documents.json'
    },
    "language": {
                  "url": "assets/dataTables.russian.lang"
    },
    columns: [
      { data: 'id' },
      { data: 'code' },
      { data: 'barcode' },
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a title='Перепечатать' data-remote='true' data-method='post' rel='nofollow' href='"+oData.url+"/reprint'><i class='material-icons'>print</i></a>");
        }
      },
      { data: 'url',
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

  var requests_table = $('#requests_table').DataTable({
    // columnDefs: [{
    //       targets: 1,
    //       render: $.fn.dataTable.render.ellipsis( 20 )
    // }],
    fixedColumns: true,
    scrollY:        '50vh',
    scrollCollapse: true,
    paging: false,
    // searching: false,
    info:     false,
    // ordering: false,
    "ajax": {
      "dataSrc": "",
      url: '/requests.json'
    },
    "language": {
                  "url": "assets/dataTables.russian.lang"
    },
    columns: [
      { data: 'url',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          $(nTd).html("<a class='details_link' title='Подробнее' data-remote='true' rel='nofollow' href='"+oData.url+"/details'><i class='material-icons'>add</i></a>");
        }
      },
      // {
      //   "className":      'details-control',
      //   "orderable":      false,
      //   "data":           null,
      //   "defaultContent": ''
      // },
      { data: 'checked',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          if (oData.checked) {
            $(nTd).html("<i class='material-icons green-text'>done</i>");
          } else {
            $(nTd).html("<i class='material-icons grey-text'>loop</i>");
          }
        }
      },
      { data: 'id' },
      { data: 'employee' },
      { data: 'created_at' },
      { data: 'closed' },
      { data: 'checked',
        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
          if (oData.checked) {
            $(nTd).html("<a class='' title='Выдать' data-remote='true' rel='nofollow' href='"+oData.url+"/close'><i class='material-icons green-text'>send</i></a>");
          } else {
            $(nTd).html("");
          }
        }
      },
     ]
  });

  var rows = []
  var details_table = $('#details_table').DataTable({
      columnDefs: [{
            targets: 1,
            render: $.fn.dataTable.render.ellipsis( 20 )
      }],
      fixedColumns: true,
      // scrollY:        '50vh',
      // scrollCollapse: true,
      paging: false,
      searching: false,
      info:     false,
      ordering: false,
      'data': rows,
      "language": {
                    "url": "assets/dataTables.russian.lang"
      },
      columns: [
        { data: 'document' },
        { data: 'created_at' },
        { data: 'expired_at' },
        { data: 'closed' },
        // { data: 'url',
        //   "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
        //     $(nTd).html("<a title='Редактировать' href='"+oData.url+"/edit?archive="+isArchive+"'><i class='material-icons'>edit</i></a>");
        //   }
        // },
        // { data: 'url',
        //   "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
        //     $(nTd).html("<a title='Удалить' data-confirm='Точно удалить?' data-remote='true' rel='nofollow' data-method='delete' href='"+oData.url+"?archive="+isArchive+"'><i class='material-icons'>delete</i></a>");
        //   }
        // }
      ]
  });

  // function format ( d ) {
  //     // `d` is the original data object for the row
  //   return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
  //       '<tr>'+
  //           '<td>Full name:</td>'+
  //           '<td>'+d.id+'</td>'+
  //       '</tr>'+
  //       '<tr>'+
  //           '<td>Extension number:</td>'+
  //           '<td>'+d.employee+'</td>'+
  //       '</tr>'+
  //       '<tr>'+
  //           '<td>Extra info:</td>'+
  //           '<td>And any further details here (images etc)...</td>'+
  //       '</tr>'+
  //   '</table>';
  // }

  function format ( d ) {
    rows = d.entries
    details_table.clear().rows.add(rows).draw();
    return $('#outer_table').html()
  }

  // $('#requests_table tbody').on('click', 'td.details-control', function () {
  //   var tr = $(this).closest('tr');
  //   var row = requests_table.row( tr );

  //   if ( row.child.isShown() ) {
  //     // This row is already open - close it
  //     row.child.hide();
  //     tr.removeClass('shown');
  //   }
  //   else {
  //     // Open this row
  //     row.child( format(row.data()) ).show();
  //     tr.addClass('shown');
  //   }
  // });

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
  $.fn.dataTableExt.sErrMode = "console";
  Materialize.updateTextFields();
  $('.modal').modal();
})

