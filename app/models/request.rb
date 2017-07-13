class Request < ApplicationRecord
  belongs_to :employee
  has_many :entries, dependent: :destroy

  accepts_nested_attributes_for :entries

  scope :active, -> { includes(:entries).where(sent: true, closed: false)}
end
