class Request < ApplicationRecord
  belongs_to :employee
  has_many :entries, dependent: :destroy

  accepts_nested_attributes_for :entries

  scope :active, -> { includes(:entries).where(sent: true, closed: false) }

  def checked
    if entries.where(checked: false).count > 0
      return false
    else
      return true
    end
  end

  def close
    update!(closed: !closed) if checked
  end
end
