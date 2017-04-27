class DocumentsController < ApplicationController
  before_action :load_document, only: [:edit, :update, :destroy]

  def index
    respond_with(@documents = Document.all)
  end

  def new
    respond_with(@document = Document.new)
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
    @document = Document.create(document_params)
    respond_with @document, location: -> { root_path }
  end

  private

  def document_params
    params.require(:document).permit(:code, :barcode)
  end

  def load_document
    @document = Document.find(params[:id])
  end
end
