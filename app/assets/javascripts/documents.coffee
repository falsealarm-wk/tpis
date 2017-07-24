jQuery(document).on 'turbolinks:load', ->
  $('#entries').select2
    tags: true,
    ajax: {
      url: '/documents'
      data: (params) ->
        {
          code: params.term
        }
      dataType: 'json'
      delay: 500
      processResults: (data, params) ->
        {
          results: _.map(data, (el) ->
            {
              id: el.id
              name: "#{el.code}"
              taken: el.taken
            }
          )
        }
      cache: true
    }
    escapeMarkup: (markup) -> markup
    minimumInputLength: 2
    templateResult: (item) ->
      if item.taken
        "<span class='taken'>"+item.name+" - выдано</span>"
      else
        item.name

    templateSelection: (item) ->
      if item.taken
        "<span class='taken'>"+item.name+"</span>"
      else
        item.name
