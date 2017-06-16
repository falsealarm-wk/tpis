class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/html_outputter'

  def html_barcode
    Barby::Code128B.new(barcode) if barcode
  end
end
