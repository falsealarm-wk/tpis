class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.references :employee, foreign_key: true
      t.references :document, foreign_key: true
      t.datetime :expired_at
      t.boolean :closed, default: false

      t.timestamps
    end
    add_index :entries, [:employee_id, :document_id]
  end
end
