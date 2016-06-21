json.array!(@emailers) do |emailer|
  json.extract! emailer, :id
  json.url emailer_url(emailer, format: :json)
end
