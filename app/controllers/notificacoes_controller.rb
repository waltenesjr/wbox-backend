class NotificacoesController < ApplicationController
  
  def notificacao

    tiposnotificacao = TipoNotificacao.where(ativo: true)

    tiposnotificacao.each do |tipo|
      produtos = Produto.where(data_vencimento: Date.today + tipo.qtd_dias.days).order(:data_vencimento)

      produtos.each do |p|
        p.usuarios.each do |usuario|

          if !usuario.ausente and usuario.possui_periodo_valido
            quantidade = NotificacaoOffline.where(data_notificacao: Date.today, usuario_id: usuario.id, produto_id: p.id).count

            if quantidade == 0
              logger.info "Enviando notificacao online de " + tipo.qtd_dias.to_s + " dias para usuario: " + usuario.id.to_s + " do produto: " + p.id.to_s + "."
              envia_notificacao_online(usuario, tipo.mensagem, tipo.qtd_dias)
            end
          end
        end
      end
    end
    render nothing: true
  end

  def envia_notificacao_online(usuario, mensagem, notId)
    
    if !Rpush::Gcm::App.find_by_name("warningbox")
      app = Rpush::Gcm::App.new
      app.name = "warningbox"
      app.auth_key = "AIzaSyCJFrGnTMykZ4O2cCnkO3KkbQY6a7SbZj0"
      app.connections = 1
      app.save!
    end
    
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("warningbox")
    n.priority = 'high'
    n.registration_ids = usuario.idpush
    n.sound = "android.resource://audio.m4a"
    message = mensagem
    n.data = { title: "WarningBox",
               message: message,
               soundname: 'audio',
               notId: notId.to_s,
               style: 'inbox',
               ledColor: [0, 0, 0, 255],
               symmaryText: 'Existem %n% notificações' }
    n.save!

  end

  def enviar_notificacao_push
    usuario = Usuario.find(params[:usuario_id])

    mensagem = params[:mensagem]
    notid = params[:notid]

    envia_notificacao_online(usuario, mensagem, notid)

    head :ok, content_type: "text/html"
  end
  
  def existe_notificacao

    usuario_id = params.require(:usuario_id)

    retorno = []
    
    if Usuario.find(usuario_id).possui_periodo_valido

      data_referencia = params.require(:data_referencia).to_date

      tiposnotificacao = TipoNotificacao.where(ativo: true)


    	tiposnotificacao.each do |tipo|
        quantidade = Produto.joins(:usuarios).where(usuarios: {id: usuario_id, ausente: 'f'}, data_vencimento: data_referencia + tipo.qtd_dias.days).where.not(id: NotificacaoOffline.select("produto_id").where(data_notificacao: data_referencia, usuario_id: usuario_id)).count

    		if quantidade > 0
    			retorno << { id: tipo.qtd_dias, mensagem: tipo.mensagem}
    		end
    	end

    end

  	render :json => retorno
  end

  def efetivar_notificacao_offline
    usuario_id = params.require(:usuario_id)

    data_referencia = params.require(:data_referencia).to_date

    tiposnotificacao = TipoNotificacao.where(ativo: true)
    usuario = Usuario.find(usuario_id)

    tiposnotificacao.each do |tipo|
      @produtos = Produto.joins(:usuarios).where(usuarios: {id: usuario_id, ausente: 'f'}, data_vencimento: data_referencia + tipo.qtd_dias.days).where.not(id: NotificacaoOffline.select("produto_id").where(data_notificacao: data_referencia, usuario_id: usuario_id))

      @produtos.each do |produto|
        notificacao_offline = NotificacaoOffline.new(usuario: usuario, produto: produto, data_notificacao: data_referencia)
        if notificacao_offline.save
          head :ok, content_type: "text/html"
        else
          render :json => notificacao_offline.errors
        end
      end
    end

    head :ok, content_type: "text/html"
  end

  def listar_alertas_do_dia
    usuario_id = params.require(:usuario_id)

    data_referencia = params.require(:data_referencia).to_date

    tiposnotificacao = TipoNotificacao.where(ativo: true)

    datas = []

    tiposnotificacao.each do |tipo|
      datas << data_referencia + tipo.qtd_dias.days
    end

    render :json =>  Estabelecimento.joins(:usuarios).where(usuarios: {id: usuario_id, ausente: 'f'}).includes(:produtos).where('produtos.data_vencimento' => datas).to_json(:include => :produtos)
  end
end
