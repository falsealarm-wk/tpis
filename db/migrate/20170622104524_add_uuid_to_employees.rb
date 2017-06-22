class AddUuidToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :uuid, :string, index: true
  end
end
