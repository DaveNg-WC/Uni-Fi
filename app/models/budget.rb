class Budget < ApplicationRecord
  belongs_to :user
  has_many :budgets_categories
  has_many :categories, through: :budgets_categories
  validates :name, presence: true
  validates :amount, presence: true
end
