json.array! @documents do |document|
  json.id document.id
  json.code document.code
  json.barcode document.barcode
  json.taken document.taken
  json.url url_for(document)
end
