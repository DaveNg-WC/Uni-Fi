class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.text :description
      t.decimal :amount
      t.date :date
      t.references :debit, null: false, foreign_key: true
      t.references :income, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
