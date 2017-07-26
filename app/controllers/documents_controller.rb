class DocumentsController < ApplicationController
  before_action :load_document, only: [:edit, :update, :destroy, :reprint]
  respond_to :js, only: [:add_new_document, :find, :reprint]
  respond_to :json, only: [:index]

  def index
    if params[:employee_id]
      employee = Employee.find(params[:employee_id])
      documents_ids = employee.open_entries.pluck(:document_id)
      @documents = Document.where(id: documents_ids).search_by_barcode(params[:barcode])
    elsif params[:barcode]
      employee = Employee.find(params[:employee_id])
      documents_ids = employee.open_entries.pluck(:document_id)
      @documents = Document.where(id: documents_ids).search_by_barcode(params[:barcode])
    elsif params[:code]
      @documents = Document.search_by_code(params[:code])
    else
      @documents = Document.all
    end
    respond_with(@documents)
  end

  def new
    @documents = []
    @documents << Document.new
    respond_with(@documents << Document.new)
  end

  def edit
    respond_with(@document)
  end

  def update
    @document.update(document_params)
    respond_with @document, location: -> { root_path }
  end

  def destroy
    respond_with(@document.destroy)
  end

  def create
    params["documents"].each do |id, document|
      if (document[:code] && document[:barcode])
        document = Document.create(document_params(document))
      end
    end
    respond_with '', location: -> { documents_path }
  end

  def receive

  end

  def add_new_document
  end

  def reprint
    barcode = Barcode.find_or_create_by(barcode: @document.barcode) do |barcode|
      barcode.printed = true
    end
    barcodes = Barcode.where(id: barcode.id)
    BarcodesPrinter.new(barcodes).perform
  end

  private

  def document_params(my_params = params.require(:document))
    my_params.permit(:code, :barcode)
  end

  def load_document
    @document = Document.find(params[:id])
  end

end
