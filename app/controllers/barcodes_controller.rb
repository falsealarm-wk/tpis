class BarcodesController < ApplicationController
  respond_to :json

  after_action :set_printed, only: [:create]

  def new
  end

  def create
    quantity = params[:quantity].to_i
    barcodes = Barcode.generate_barcode(quantity)
    CSV.open("c:/file.csv", "wb") do |csv|
      csv << ["barcode"]
      Barcode.to_print.find_each do |barcode|
        csv << [barcode.barcode]
      end
    end
    redirect_to root_path
  end

  def index
    @barcodes = Barcode.order(:created_at).page(params[:page])
    respond_with @barcodes
  end

  private

  def set_printed
    Barcode.to_print.update_all(printed: true)
  end
end
