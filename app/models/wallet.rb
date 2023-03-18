class Wallet < ApplicationRecord
  belongs_to :user

  enum type: {
    debit: 'debit',
    credit: 'credit'
  }
  # After defining the enum, you can use it in your application code like this:
  # create a new transaction with type 'income'
  # t = Transaction.new(type: :income, description: 'Salary', amount: 1000.0, date: Date.today)
end
