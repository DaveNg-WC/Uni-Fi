class CreateDebits < ActiveRecord::Migration[7.0]
  def change
    create_table :debits do |t|
      t.string :name
      t.text :description
      t.float :balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
