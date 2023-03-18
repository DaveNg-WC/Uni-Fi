json.extract! wallet, :id, :name, :type, :payment_due_date, :user_id, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
