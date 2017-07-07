json.array! @employees do |employee|
  json.name employee.name
  json.uuid employee.uuid
  json.department employee.department
  json.email employee.email
  json.phone employee.phone
  json.url url_for(employee)
end
