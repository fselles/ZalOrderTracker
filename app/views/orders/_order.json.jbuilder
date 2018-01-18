json.extract! order, :id, :customer, :order_number, :despatch_date, :status, :comments, :created_at, :updated_at
json.url order_url(order, format: :json)
