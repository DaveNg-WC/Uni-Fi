class CreateJoinTableBudgetsCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :budgets, :categories do |t|
      t.index :budget_id
      t.index :category_id
    end
  end
end
