class RequestsController < ApplicationController
  # before_action :authenticate_user!
  before_action :check_documents, only: :create
  before_action :load_request, only: [:details, :close, :verify_documents]
  # after_action :send_request, only: :create

  respond_to :json, only: :index
  respond_to :js, only: [:details, :close, :verify_documents]


  def index
    @requests = Request.active
  end

  def new
    respond_with @request = Request.new
  end

  def create
    @documents.each do |document|
      @request.entries << Entry.new(document_id: document.id, employee_id: params[:employee_id])
    end
    @request.save! if (@request.entries.any? || @request.documents.any?)
    respond_with @request, location: -> { root_path }
  end

  # def update
  #   @request = Request.find params[:id]

  #   respond_to do |format|
  #     if @user.update_attributes(params[:request])
  #       format.html { redirect_to(@request, :notice => 'User was successfully updated.') }
  #       format.json { respond_with_bip(@request) }
  #     else
  #       format.html { render :action => "edit" }
  #       format.json { respond_with_bip(@request) }
  #     end
  #   end
  # end

  def verify_documents
    params["documents"].try(:each) do |id, document|
      if (document[:code] && document[:barcode])
        new_document = Document.find(id)
        new_document.update!(code: document[:code], barcode: document[:barcode])
        new_document.convert_to_entry
      end
    end
    @entries = @request.entries
    respond_with @request
  end


  def details
    @entries = @request.entries.includes(:document)
    @new_documents = @request.documents
    respond_with @entries
  end

  def close
    @request.close
    respond_with @request
  end

  private

  def check_documents
    @documents = []
    @request = Request.new(employee_id: params[:employee_id])
    if !params["documents"] && !params["records"]
      @request.errors.add(:entries, :empty)
      flash.now[:notice] = 'Выберите необходимые техпроцессы'
      respond_with @request
    else
      params["records"].each do |record|
        @request.documents << Document.new(code: record[:code], skip_barcode_validation: true) unless record[:code].blank?
      end
      params["documents"].try(:each) do |document_id|
        document = Document.find(document_id)
        @documents << document if !document.taken
      end
    end
  end

  def load_request
    @request = Request.find(params[:id])
  end

end
