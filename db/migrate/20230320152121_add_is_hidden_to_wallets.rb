class AddIsHiddenToWallets < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :is_hidden, :boolean, default: false
  end
end
