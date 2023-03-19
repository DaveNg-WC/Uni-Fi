json.extract! wallet, :id, :name, :wallet_type, :payment_due_date, :user_id, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
