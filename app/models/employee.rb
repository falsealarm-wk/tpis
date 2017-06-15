class Employee < ApplicationRecord
  has_many :entries, dependent: :nullify
end
