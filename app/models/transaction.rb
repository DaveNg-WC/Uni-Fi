class Transaction < ApplicationRecord
  belongs_to :debit
  belongs_to :income
  belongs_to :expense
  belongs_to :user

  enum type: {
    income: 'income',
    transfer: 'transfer',
    expense: 'expense'
  }
  # After defining the enum, you can use it in your application code like this:
  # create a new transaction with type 'income'
  # t = Transaction.new(type: :income, description: 'Salary', amount: 1000.0, date: Date.today)

  # When you save the transaction to the database,
  # the type attribute will be stored as a string value corresponding to the named value you specified in the enum.
  # For example, if you set type to :income, the value will be stored as the string 'income' in the database.
end
