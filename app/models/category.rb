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

  def total_balance
    balance = 0

    self.transactions.each do |t|
      balance += t.amount
    end

    balance
  end

  def this_month_balance
    balance = 0
    self.transactions.where('extract(month from date) = ?', Time.now.month).each do |t|
      balance += t.amount
    end
    balance
  end

  def last_month_balance
    balance = 0
    self.transactions.where('extract(month from date) = ?', Time.now.month-1).each do |t|
      balance += t.amount
    end
    balance
  end

  def month_balance(month)
    balance = 0
    self.transactions.where('extract(month from date) = ?', month).each do |t|
      balance += t.amount
    end
    balance
  end

end
