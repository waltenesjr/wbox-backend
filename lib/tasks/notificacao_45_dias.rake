desc 'envia notificacoes de 45 dias'

task notificacao_45_dias: :environment do
  # ... set options if any
  Vencimento.new.notificacao_45_dias()
end
