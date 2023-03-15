class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.string :name
      t.text :description
      t.float :balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
