class CreateBarcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :barcodes do |t|
      t.string :barcode, unique: true

      t.timestamps
    end
  end
end
