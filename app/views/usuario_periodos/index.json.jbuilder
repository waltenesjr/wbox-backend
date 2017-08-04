json.array!(@usuario_periodos) do |usuario_periodo|
  json.extract! usuario_periodo, :id, :usuario_id, :inicio_periodo, :fim_periodo, :situacao
  json.url usuario_periodo_url(usuario_periodo, format: :json)
end
