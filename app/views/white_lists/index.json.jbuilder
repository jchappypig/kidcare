json.array!(@white_lists) do |white_list|
  json.extract! white_list, :id, :email
  json.url white_list_url(white_list, format: :json)
end
