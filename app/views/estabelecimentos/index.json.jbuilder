json.array!(@estabelecimentos) do |estabelecimento|
  json.extract! estabelecimento, :id, :nome
  json.url estabelecimento_url(estabelecimento, format: :json)
end
