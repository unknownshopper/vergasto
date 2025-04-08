json.extract! transaction, :id, :full_name, :amount, :image, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
