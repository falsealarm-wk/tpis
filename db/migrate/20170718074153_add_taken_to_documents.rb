class AddTakenToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :taken, :boolean, default: false
  end
end
