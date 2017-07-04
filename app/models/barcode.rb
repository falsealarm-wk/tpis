class Barcode < ApplicationRecord
  include HasBarcode

  has_barcode :barcode_view,
      outputter: :html,
      type: :code_128,
      value: Proc.new { |p| p.number }

  scope :to_print, -> { where(printed: false) }

  after_create :generate_token, if: Proc.new{ |barcode| !barcode.printed }

  def number
    self.barcode
  end

  def self.generate_barcode(quantity)
    quantity.times { Barcode.create }
  end

  private

  def generate_token
    update!(barcode: Time.zone.now.to_i + id)
  end
end
