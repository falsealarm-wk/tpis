require 'net/http'
class BarcodesPrinter
  def initialize(barcodes=Barcode.to_print)
    @uri = URI.parse(ENV['PRINT_FILE_URI'])
    @barcodes = barcodes
  end

  def perform
    print_barcodes
  end

  def get_api_call
    http = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri, 'Content-Type' => 'application/json')
    barcodes_string = @barcodes.pluck(:barcode).join(",")
    request.body = {'array': barcodes_string}.to_json
    http.request(request).body
  end

  def print_barcodes
    get_api_call()
  end
end
