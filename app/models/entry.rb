class Entry < ApplicationRecord
  belongs_to :employee
  belongs_to :document

  before_create :set_expiration

  default_scope { order(closed: :asc, created_at: :desc)}
  private

  def set_expiration
    self.expired_at = Time.zone.now + 1.month
  end

end
