json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :email
  json.url usuario_url(usuario, format: :json)
end
