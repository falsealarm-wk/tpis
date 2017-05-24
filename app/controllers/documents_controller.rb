class DocumentsController < ApplicationController
  before_action :load_document, only: [:edit, :update, :destroy]
  respond_to :js, only: [:add_new_document, :find]
  respond_to :json, only: [:index]

  def index
    if params[:code]
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
    params["documents"].each do |document|
      if (document[:code] && document[:barcode])
        document = Document.create(document_params(document))
      end
    end
    respond_with '', location: -> { documents_path }
  end

  def add_new_document
  end

  def find
    code = params[:code]
    @id = params[:id]
    @document = Document.where(code: code).first
  end

  private

  def document_params(my_params = params.require(:document))
    my_params.permit(:code, :barcode)
  end

  def load_document
    @document = Document.find(params[:id])
  end

end
