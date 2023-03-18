class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :name, null: false
      t.string :wallet_type, null: false
      t.text :description
      t.date :payment_due_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
