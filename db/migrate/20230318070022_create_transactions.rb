class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.text :description
      t.string :txn_type, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.decimal :amount, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
