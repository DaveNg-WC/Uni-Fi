json.extract! transaction, :id, :description, :type, :user_id, :category_id, :amount, :date, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
