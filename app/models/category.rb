class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :budgets_categories
  has_many :budgets, through: :budgets_categories
  validates :name, presence: true


  def expense?
    self.category_type.downcase == "expense"
  end

  def income?
    self.category_type.downcase == "income"
  end

  def balance
    sum = 0
    self.transactions.each do |t|
      sum += t.amount
    end
    sum
  end
end
