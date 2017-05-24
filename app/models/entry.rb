class Entry < ApplicationRecord
  belongs_to :employee
  belongs_to :document

  before_create :set_expiration

  private

  def set_expiration
    self.expired_at = Time.zone.now + 1.month
  end

end
