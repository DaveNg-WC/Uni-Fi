class CreateJoinTableUsersPartners < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :partners do |t|
      t.index :user_id
      t.index :partner_id
    end
  end
end
