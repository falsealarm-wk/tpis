class BarcodesController < ApplicationController
  respond_to :json

  after_action :print, only: [:create]

  def new
  end

  def create
    quantity = params[:quantity].to_i
    barcodes = Barcode.generate_barcode(quantity)
    redirect_to root_path
  end

  def index
    @barcodes = Barcode.order(:created_at).page(params[:page])
    respond_with @barcodes
  end

  private

  def print
    BarcodesPrinter.new.perform
    Barcode.to_print.update_all(printed: true)
  end
end
