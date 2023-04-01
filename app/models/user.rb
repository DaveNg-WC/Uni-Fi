class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :wallets, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_one :partnership
  has_one :partner, through: :partnership


  def incomes
    self.categories.where(category_type: :Income)
  end

  def expenses
    self.categories.where(category_type: :Expense)
  end

end
