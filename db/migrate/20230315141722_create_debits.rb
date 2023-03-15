class CreateDebits < ActiveRecord::Migration[7.0]
  def change
    create_table :debits do |t|
      t.string :name
      t.text :description
      t.decimal :balance, default: 0.0 # Set default value to $0.00
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
