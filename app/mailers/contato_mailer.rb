class ContatoMailer < ApplicationMailer
	default :from => 'suporte@warningbox.com.br'

	def mensagem_recuperacao_senha(email, codigo)
	    @codigo = codigo
	    mail(:to => email, :subject => 'Recuperação de senha do WarningBox')
	  end
end
