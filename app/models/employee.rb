class Employee < ApplicationRecord
  has_many :entries, dependent: :nullify
  has_many :expired_documents, -> { includes(:document).where(closed: false).where('entries.expired_at < ?',Time.zone.now) }, class_name: 'Entry'
  has_many :open_entries, -> { includes(:document, :employee).where(closed: false) }, class_name: 'Entry'

  scope :with_expired_documents, -> { joins(:entries).where('entries.expired_at < ?',Time.zone.now).uniq }
end
