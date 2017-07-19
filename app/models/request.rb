class Request < ApplicationRecord
  belongs_to :employee
  has_many :entries, dependent: :destroy

  accepts_nested_attributes_for :entries

  scope :active, -> { includes(:entries).where(sent: true, closed: false) }

  after_create :send_request

  def checked
    if entries.where(checked: false).count > 0
      return false
    else
      return true
    end
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
