class AddWalletsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :main_wallet, null: false, foreign_key: { to_table: :wallets }
    add_reference :transactions, :second_wallet, foreign_key: { to_table: :wallets }
  end
end
