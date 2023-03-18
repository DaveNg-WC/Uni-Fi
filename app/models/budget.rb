class Budget < ApplicationRecord
  belongs_to :user
  has_many :expenses
end
