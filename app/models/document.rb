class Document < ApplicationRecord
  include PgSearch
  validates :code, :barcode, presence: true, uniqueness: true
  has_many :entries, dependent: :destroy

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

end
