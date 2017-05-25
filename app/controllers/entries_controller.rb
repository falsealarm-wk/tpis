class EntriesController < ApplicationController
  before_action :load_entry, only: [:destroy]
  respond_to :json, only: [:index]

  def index
    if params[:barcode]
      employee = Employee.find(params[:employee_id])
      documents_ids = employee.entries.where(closed: false).pluck(:document_id)
      @entries = Document.where(id: documents_ids).search_by_barcode(params[:barcode])
    else
      @entries = Entry.includes(:employee, :document)
    end
    respond_with(@entries)
  end

  def new
    respond_with(@entry = Entry.new)
  end

  def create
    params["documents"].each do |document_id|
      entry = Entry.create(document_id: document_id, employee_id: params[:employee_id])
    end
    respond_with '', location: -> { entries_path }
  end

  def destroy
    respond_with(@entry.destroy)
  end


  def extend
    params["documents"].each do |document_id|
      entry = Entry.where(document_id: document_id, employee_id: params[:employee_id]).first
      entry.update!(expired_at: (entry.expired_at + 1.month))
    end
    respond_with '', location: -> { entries_path }
  end

  private

  def load_entry
    @entry = Entry.find(params[:id])
  end

end
