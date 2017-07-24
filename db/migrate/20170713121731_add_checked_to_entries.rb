class AddCheckedToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :checked, :boolean, default: false
  end
end
