class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :budgets, through: :budgets_categories

  # enum type: {
  #   income: 'income',
  #   expense: 'expense'
  # }
  # After defining the enum, you can use it in your application code like this:
  # create a new category with type 'income'
  # t = Category.new(type: :income, name: "food", user_id: 1)
end
