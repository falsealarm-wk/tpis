class Barcode < ApplicationRecord
  include HasBarcode

  has_barcode :barcode_view,
      :outputter => :html,
      :type => :code_128,
      :value => Proc.new { |p| p.number }

  scope :to_print, -> { where(printed: false) }

  def number
    self.barcode
  end

  after_create :generate_token

  def self.generate_barcode(quantity)
    quantity.times { Barcode.create }
  end

  private

  def generate_token
    update!(barcode: Time.zone.now.to_i + id)
  end
end
