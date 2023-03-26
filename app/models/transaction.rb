class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  # belongs_to :wallet
  belongs_to :main_wallet, class_name: 'Wallet', foreign_key: 'main_wallet_id'
  belongs_to :second_wallet, class_name: 'Wallet', foreign_key: 'second_wallet_id', optional: true
  validates :main_wallet, presence: true

  def income?
    self.txn_type.downcase == "income"
  end

  def expense?
    self.txn_type.downcase == "expense"
  end

  def transfer?
    self.txn_type.downcase == "transfer"
  end
end
