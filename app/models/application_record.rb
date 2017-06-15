class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/html_outputter'
  require 'barby/outputter/png_outputter'
  require 'barby/outputter/svg_outputter'

  def html_barcode
    Barby::Code128B.new(barcode) if barcode
  end

  def png_barcode
    barcode128 = Barby::Code128B.new(barcode) if barcode
    File.open('barcode128.png', 'wb'){|f| f.write barcode128.to_png(:height => 40, :margin => 5) }
  end
end
