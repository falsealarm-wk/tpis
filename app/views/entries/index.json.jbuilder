json.array! @entries do |entry|
  json.id entry.id
  json.employee entry.employee.name
  json.document entry.document.code
  json.created_at entry.created_at.strftime("%d.%m.%Y")
  json.expired_at entry.expired_at.strftime("%d.%m.%Y")
  json.closed bool_to_text(entry.closed)
  json.url url_for(entry)
end
