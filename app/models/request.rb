class Request < ApplicationRecord
  belongs_to :user

  has_many :entries, through:
end
