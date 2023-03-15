json.extract! transaction, :id, :type, :description, :amount, :date, :debit_id, :income_id, :expense_id, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
