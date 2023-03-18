class Wallet < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :type, :balance

  enum type: {
    debit: 'debit',
    credit: 'credit'
  }
  # After defining the enum, you can use it in your application code like this:
  # create a new wallet with type 'debit'
  # t = Wallet.new(type: :debit, name: "DBS")
end
