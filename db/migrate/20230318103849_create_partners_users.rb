class CreatePartnersUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :partners_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :partner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
