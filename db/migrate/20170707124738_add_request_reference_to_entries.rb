class AddRequestReferenceToEntries < ActiveRecord::Migration[5.0]
  def change
    add_reference :entries, :request, foreign_key: true, index: true
  end
end
