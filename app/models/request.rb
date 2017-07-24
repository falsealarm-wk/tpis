class Request < ApplicationRecord
  belongs_to :employee
  has_many :entries, dependent: :destroy
  has_many :documents

  accepts_nested_attributes_for :entries
  scope :active, -> { includes(:entries).where(sent: true, closed: false) }

  after_create :send_request

  def checked
    (entries.where(checked: false).any? || documents.any?) ? false : true
  end

  def close
    if checked
      transaction do
        update!(closed: !closed)
        entries.update_all(created_at: Time.zone.now, expired_at: Time.zone.now + 1.month)
      end
    end
  end

  def send_request
    RequestSenderJob.perform_now(self)
  end
end
