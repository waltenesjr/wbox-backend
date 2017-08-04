json.array!(@produtos) do |produto|
  json.extract! produto, :id, :imagem, :data_vencimento, :estabelecimento_id, :created_at, :updated_at
  json.url produto_url(produto, format: :json)
end
