desc 'envia notificacoes de 3 dias'

task notificacao_3_dias: :environment do
  # ... set options if any
  Vencimento.new.notificacao_3_dias()
end