module WalletHelper
  def balance(wallet)
    transactions = Transaction.all
    transactions = transactions.where(main_wallet_id: wallet.id)
    balance = 0
    transactions.each do |t|
      balance += t.amount
    end
    balance
  end

  # def net_worth(wallets)
  #   net_worth = 0
  #   wallets.each do |wallet|
  #     balance(wallet)
  #     if wallet.wallet_type == "Debit"
  #       net_worth += balance(wallet)
  #     else
  #       net_worth -= balance(wallet)
  #     end
  #   end
  #   net_worth
  # end
end
