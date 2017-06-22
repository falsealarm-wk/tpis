class BarcodesPrinter
  def initialize(barcodes=Barcode.to_print)
    @file_path = "c:/file.csv"
    @barcodes = barcodes
  end

  def perform
    print_barcodes
  end

  def print_barcodes
    CSV.open(@file_path, "wb") do |csv|
      csv << ["barcode"]
      @barcodes.find_each do |barcode|
        csv << [barcode.barcode]
      end
    end
  end
end
