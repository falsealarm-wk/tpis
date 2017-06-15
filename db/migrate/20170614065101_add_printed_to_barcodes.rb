class AddPrintedToBarcodes < ActiveRecord::Migration[5.0]
  def change
    add_column :barcodes, :printed, :boolean, default: false
  end
end
