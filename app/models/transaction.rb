class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :wallet
end
