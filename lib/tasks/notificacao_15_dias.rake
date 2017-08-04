desc 'envia notificacoes de 15 dias'

task notificacao_15_dias: :environment do
  # ... set options if any
  Vencimento.new.notificacao_15_dias()
end
