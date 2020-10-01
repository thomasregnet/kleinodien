# frozen_string_literal: true

json.extract! import_order, :id, :code, :state, :type, :uri, :user_id, :requests_count, :import_queue_id, :created_at, :updated_at
json.url import_order_url(import_order, format: :json)
