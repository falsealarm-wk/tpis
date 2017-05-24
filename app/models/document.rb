class Document < ApplicationRecord
  include PgSearch
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/html_outputter'
  validates :code, :barcode, presence: true, uniqueness: true
  belongs_to :entry

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

  # after_create :generate_barcode

  def html_barcode
    Barby::Code128B.new(barcode) if barcode
  end

  private

  def generate_barcode
    update!(barcode: Time.zone.now.to_i.to_s+id.to_s)
  end

end
