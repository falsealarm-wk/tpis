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
            }
          )
        }
      cache: true
    }
    escapeMarkup: (markup) -> markup
    minimumInputLength: 2
    templateResult: (item) -> item.name
    templateSelection: (item) -> item.name
