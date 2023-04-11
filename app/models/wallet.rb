class Wallet < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :wallet_type

  has_many :transactions, dependent: :nullify

  def debit?
    self.wallet_type == "Debit"
  end

  def credit?
    self.wallet_type == "Credit"
  end

  def balance
    balance = 0
    Transaction.all.where(main_wallet_id: self.id).each do |t|
      balance += t.amount if t.income?
      balance -= t.amount if t.expense?
      balance -= t.amount if t.transfer?
    end
    Transaction.all.where(second_wallet_id: self.id).each do |t|
      balance += t.amount if t.transfer?
    end

    balance
  end
end
