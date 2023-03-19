class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions

  # enum wallet_type: {
  #   debit: 'debit',
  #   credit: 'credit'
  # }
  # After defining the enum, you can use it in your application code like this:
  # create a new wallet with type 'debit'
  # t = Wallet.new(type: :debit, name: "DBS")
end
