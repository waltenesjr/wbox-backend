json.array!(@tipo_notificacaos) do |tipo_notificacao|
  json.extract! tipo_notificacao, :id, :qtd_dias, :mensagem, :ativo
  json.url tipo_notificacao_url(tipo_notificacao, format: :json)
end
