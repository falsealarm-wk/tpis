json.array! @requests do |request|
  json.id request.id
  json.employee request.employee.name
  json.created_at request.created_at.strftime("%d.%m.%Y")
  json.closed bool_to_text(request.closed)
  json.url url_for(request)

  json.entries request.entries do |entry|
    json.id entry.id
    json.employee entry.employee.name
    json.document entry.document.code
    json.created_at entry.created_at.strftime("%d.%m.%Y")
    json.expired_at entry.expired_at.strftime("%d.%m.%Y")
    json.closed bool_to_text(entry.closed)
    json.url url_for(entry)
  end
end


