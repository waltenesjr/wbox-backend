desc 'envia notificacoes de 30 dias'

task notificacao_30_dias: :environment do
  # ... set options if any
  Vencimento.new.notificacao_30_dias()
end
