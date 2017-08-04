class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all.order(created_at: :desc)
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)
    @usuario.ausente = false
    usuarioPeriodo = UsuarioPeriodo.new(usuario_id: @usuario.id, inicio_periodo: Date.today, fim_periodo: '2017-12-31'.to_date, situacao: 'G')
    @usuario.usuarioPeriodos << usuarioPeriodo

    begin
      token = SecureRandom.hex(4)
      cont = Usuario.where('codigo_indicador = ?', token).count
    end while cont > 0
     
    @usuario.codigo_indicador = token

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario, notice: 'Usuario was successfully created.' }
        format.json { render json: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def consultarStatusPorEmail
    usuario = Usuario.where("email == (?)", params[:email]).first
    render :json => usuario.nil? ? 0 : usuario.ausente
  end

  def consultarPorEmail
    usuario = Usuario.where("email == (?)", params[:email]).first
    render :json => usuario.nil? ? 0 : usuario.id
  end

  def consultarSenhaPorEmail
    usuario = Usuario.where(email: params[:email]).first
    render :json => usuario.nil? ? 0 : usuario.senha
  end

  def autenticarUsuario
    usuario = Usuario.where(email: params[:email], senha: params[:senha]).first

    if usuario.nil?
      render :json => 0
    else
      usuario = Usuario.find(usuario.id)
      if usuario.usuarioPeriodos.where("inicio_periodo <= ? and ? <= fim_periodo and situacao in (?)", Date.today, Date.today, ['P', 'G'] ).count > 0
        render :json => 1
      else 
        render :json => 2
      end
    end
  end

  def enviarEmailRecuperacaoSenha
    email = params[:email]
    codigo = params[:codigo]

    usuario = Usuario.where(email: params[:email]).first

    if usuario.nil?
    	render :json => 9
    else
    	ContatoMailer.mensagem_recuperacao_senha(email, codigo).deliver
		render :json => 0
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:email, :idpush, :nome, :senha, :ausente, :codigoRecuperacaoSenha, :categoria, :codigo_de_barras, :quantidade, :valor)
    end
end
