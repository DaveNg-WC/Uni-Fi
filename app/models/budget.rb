class Budget < ApplicationRecord
  belongs_to :user
  has_many :budgets_categories
  has_many :categories, through: :budgets_categories
end
