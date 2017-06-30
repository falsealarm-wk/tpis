class EntriesController < ApplicationController
  before_action :load_entry, only: [:edit, :update, :destroy, :notify]
  respond_to :json, only: [:index]
  respond_to :js, only: [:index,:notify]

  def index
    if params[:barcode]
      employee = Employee.find(params[:employee_id])
      documents_ids = employee.open_entries.pluck(:document_id)
      @entries = Document.where(id: documents_ids).search_by_barcode(params[:barcode])
    elsif params[:employee_id]
      employee = Employee.find(params[:employee_id])
      @entries = employee.open_entries
    else
      if params[:archive] == 'true'
        @entries = Entry.includes(:employee, :document).where(closed: true).page(params[:page])
      else
        @entries = Entry.includes(:employee, :document).where(closed: false).page(params[:page])
      end
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

  def edit
    respond_with(@entry)
  end

  def update
    @entry.update(entry_params)
    respond_with @entry, location: -> { entries_path }
  end

  def destroy
    respond_with(@entry.destroy)
  end

  def prolong

  end

  def receive
  end

  def extend
    if params[:entry_id]
      entry = Entry.find(params[:entry_id])
      entry.update!(expired_at: (entry.expired_at + 1.month))
    else
      params["documents"].each do |document_id|
        entry = Entry.where(document_id: document_id, employee_id: params[:employee_id], closed: false).first
        entry.update!(expired_at: (entry.expired_at + 1.month))
      end
    end
    respond_with '', location: -> { entries_path }
  end

  def close
    params["documents"].each do |document_id|
      entry = Entry.where(document_id: document_id, employee_id: params[:employee_id], closed: false).first
      entry.update!(closed: true)
    end
    respond_with '', location: -> { entries_path }
  end

  def notify
    employee = @entry.employee
    NotificationMailer.notification(employee, @entry.document.code).deliver_later
    respond_with '', location: -> { entries_path }
  end

  private

  def entry_params
    params.require(:entry).permit(:expired_at, :closed)
  end

  def load_entry
    @entry = Entry.find(params[:id])
  end

end
