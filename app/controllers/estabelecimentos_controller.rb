class EstabelecimentosController < ApplicationController
  before_action :set_estabelecimento, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /estabelecimentos
  # GET /estabelecimentos.json
  def index
    @estabelecimentos = Estabelecimento.all
  end

  # GET /estabelecimentos/1
  # GET /estabelecimentos/1.json
  def show
  end

  # GET /estabelecimentos/new
  def new
    @estabelecimento = Estabelecimento.new
  end

  # GET /estabelecimentos/1/edit
  def edit
  end

  # POST /estabelecimentos
  # POST /estabelecimentos.json
  def create
    @estabelecimento = Estabelecimento.new(estabelecimento_params)
    @usuario = Usuario.find(usuario_params[:id])
    @estabelecimento_usuario = EstabelecimentosUsuario.create(estabelecimento: @estabelecimento, usuario: @usuario, ic_criador: true)

    respond_to do |format|
      if @estabelecimento.save
        format.html { redirect_to @estabelecimento, notice: 'Estabelecimento was successfully created.' }
        format.json { render json: @estabelecimento }
      else
        format.html { render :new }
        format.json { render json: @estabelecimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estabelecimentos/1
  # PATCH/PUT /estabelecimentos/1.json
  def update
    respond_to do |format|
      if @estabelecimento.update(estabelecimento_params)
        format.html { redirect_to @estabelecimento, notice: 'Estabelecimento was successfully updated.' }
        format.json { render :show, status: :ok, location: @estabelecimento }
      else
        format.html { render :edit }
        format.json { render json: @estabelecimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estabelecimentos/1
  # DELETE /estabelecimentos/1.json
  def destroy
    @estabelecimento.estabelecimentos_usuarios.clear
    @estabelecimento.produtos.clear
    @estabelecimento.destroy
    respond_to do |format|
      format.html { redirect_to estabelecimentos_url, notice: 'Estabelecimento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def consultarPorUsuario
    estabelecimentos = Estabelecimento.joins(estabelecimentos_usuarios: :usuario).includes(:estabelecimentos_usuarios).where('usuarios.email == ?', params[:usuario]).to_json(:include => :estabelecimentos_usuarios)
    render :json => estabelecimentos
  end

  def compartilharEstabelecimento
    @estabelecimento = Estabelecimento.find(params[:idEstabelecimento])
    @usuario = Usuario.where("email == (?)", params[:emailCompartilhar]).first

    if @usuario.nil?
      render :json => 0
    elsif @usuario.possui_periodo_valido

      cont = EstabelecimentosUsuario.where(estabelecimento: @estabelecimento, usuario: @usuario, ic_criador: false).count

      if cont == 0
        @estabelecimento_usuario = EstabelecimentosUsuario.create(estabelecimento: @estabelecimento, usuario: @usuario, ic_criador: false)
        envia_notificacao_push(@usuario, 'Um estabelecimento foi compartilhado com você. Acesse o WarningBox para conferir.', '99')
        render :json => 1
      else
        render :json => 3
      end
    else
      render :json => 2
    end
  end

  def transferirEstabelecimento
    @estabelecimento = Estabelecimento.find(params[:idEstabelecimento])
    @usuario = Usuario.where("email == (?)", params[:emailTransferir]).first

    if @usuario.nil?
      render :json => 0
    elsif @usuario.possui_periodo_valido 
      estabelecimento_usuario_antigo = EstabelecimentosUsuario.delete_all(:estabelecimento_id => @estabelecimento.id, :ic_criador => true)
      @estabelecimento_usuario = EstabelecimentosUsuario.create(estabelecimento: @estabelecimento, usuario: @usuario, ic_criador: true)
          
      envia_notificacao_push(@usuario, 'Um estabelecimento foi transferido para você. Acesse o WarningBox para conferir.', '98')

      render :json => 1
    else
      render :json => 2
    end
  end

  def transferirTodosEstabelecimentos
    @usuario = Usuario.where("email == (?)", params[:emailUsuario]).first
    usuarioTransferencia = Usuario.where("email == (?)", params[:emailTransferencia]).first

    if usuarioTransferencia.nil?
      @usuario.estabelecimentos.each do |estabe| 
        @estabelecimento_usuario = EstabelecimentosUsuario.create(estabelecimento: estabe, usuario: @usuarioTransferencia, ic_criador: false)
      end
      render :json => 1
    else
      render :json => 0
    end
  end

  def consultarPorNome
    nome = params.require(:nomeEstabelecimento)
    usuario_id = params.require(:usuario_id)
    estabelecimento = Estabelecimento.joins(:usuarios).where(usuarios: {id: usuario_id, ausente: 'f'}, nome: nome).count

    if estabelecimento == 0
      render :json => 0
    else
      render :json => 1 
    end
  end

  def excluirCompartilhamento
    estabelecimento_id = params[:estabelecimento_id]
    usuario_id = params[:usuario_id]

    estabelecimento_usuario = EstabelecimentosUsuario.delete_all(:estabelecimento_id => estabelecimento_id, :usuario_id => usuario_id)
    
    render :json => 0 

  end

  def listarEstabelecimentosCompartilhados
    usuario_id = params[:usuario_id]

    estabelecimentos = Estabelecimento.joins(:usuarios).where('usuario_id = ? and estabelecimentos_usuarios.ic_criador = ?', usuario_id, true)

    lista = []

    estabelecimentos.each do |estab|
      if estab.estabelecimentos_usuarios.size > 1
        lista << estab
      end
    end

    render :json => lista.to_json(:include => :estabelecimentos_usuarios)
  end

  def envia_notificacao_push(usuario, mensagem, notId)
    
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estabelecimento
      @estabelecimento = Estabelecimento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estabelecimento_params
      params.require(:estabelecimento).permit(:nome, :usuario_id)
    end
    
    def usuario_params
      params.require(:usuario).permit(:id)
    end
end
