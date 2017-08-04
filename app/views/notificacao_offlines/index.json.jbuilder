json.array!(@notificacao_offlines) do |notificacao_offline|
  json.extract! notificacao_offline, :id, :produto_id, :usuario_id, :data_notificacao
  json.url notificacao_offline_url(notificacao_offline, format: :json)
end
