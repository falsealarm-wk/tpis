class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.boolean :sent, default: false
      t.boolean :closed, default: false
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
