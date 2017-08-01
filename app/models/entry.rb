class Entry < ApplicationRecord
  belongs_to :employee
  belongs_to :document
  belongs_to :request

  before_create :set_expiration
  before_create :take_document

  default_scope { order(closed: :asc, created_at: :desc)}

  def check
    update!(checked: !checked)
  end

  def done
    update!(closed: !closed)
    document.release
  end

  private

  def set_expiration
    self.expired_at = Time.zone.now + 1.month
  end

  def take_document
    document.update!(taken: true)
  end

end
