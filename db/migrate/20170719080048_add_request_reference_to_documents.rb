class AddRequestReferenceToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_reference :documents, :request, foreign_key: true
  end
end
