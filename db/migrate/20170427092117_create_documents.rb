class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :code
      t.string :barcode

      t.timestamps
    end
  end
end
