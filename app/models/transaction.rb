class Transaction < ApplicationRecord
  belongs_to :debit
  belongs_to :income
  belongs_to :expense
  belongs_to :user
end
