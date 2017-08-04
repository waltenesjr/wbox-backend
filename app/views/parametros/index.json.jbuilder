json.array!(@parametros) do |parametro|
  json.extract! parametro, :id, :nome, :valor
  json.url parametro_url(parametro, format: :json)
end
