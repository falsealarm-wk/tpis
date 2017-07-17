class RequestsController < ApplicationController
  before_action :check_documents, only: :create
  before_action :load_request, only: [:details, :close]
  after_action :send_request, only: :create

  respond_to :json, only: :index
  respond_to :js, only: [:details, :close]


  def index
    @requests = Request.active
  end

  def new
    respond_with @request = Request.new
  end

  def create
    params["documents"].each do |document_id|
      @request.entries << Entry.new(document_id: document_id, employee_id: params[:employee_id])
    end
    @request.save!
    respond_with @request, location: -> { root_path }
  end

  def update
    @request = Request.find params[:id]

    respond_to do |format|
      if @user.update_attributes(params[:request])
        format.html { redirect_to(@request, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@request) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@request) }
      end
    end
  end

  def details
    @entries = @request.entries.includes(:document)
    respond_with @entries
  end

  def close
    @request.close
    respond_with @request
  end


  private

  def check_documents
    @request = Request.new(employee_id: params[:employee_id])
    if !params["documents"]
      @request.errors.add(:entries, :empty)
      flash.now[:notice] = 'Выберите необходимые техпроцессы'
      respond_with @request
    end
  end

  def send_request
    RequestSenderJob.perform_now(@request)
  end

  def load_request
    @request = Request.find(params[:id])
  end
end
