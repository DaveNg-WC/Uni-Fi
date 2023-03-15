json.extract! debit, :id, :name, :description, :balance, :user_id, :created_at, :updated_at
json.url debit_url(debit, format: :json)
