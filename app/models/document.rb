class Document < ApplicationRecord
  include PgSearch
  attr_accessor :skip_barcode_validation
  validates :barcode, presence: true, uniqueness: true, unless: :skip_barcode_validation
  validates :code, presence: true, uniqueness: true
  has_many :entries, dependent: :destroy
  belongs_to :request, optional: true
  default_scope -> { order('created_at DESC') }
  pg_search_scope :search_by_code, against: [:code],
    using: {
      tsearch: {
        prefix: true
      }
    }

  pg_search_scope :search_by_barcode, against: [:barcode],
    using: {
      tsearch: {
        prefix: true
      }
    }

  # has_many :current_owner, -> { includes(:entries, :employee).where(closed: false) }, class_name: 'Employee'

  def convert_to_entry
    transaction do
      if !taken
        Entry.create!(request_id: request.id, document_id: id, employee_id: request.employee_id)
        update!(request_id: nil)
      end
    end
  end

  def release
    update!(taken: true)
  end
end
