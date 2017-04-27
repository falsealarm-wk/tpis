class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :department
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
