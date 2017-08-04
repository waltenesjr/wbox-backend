class TipoNotificacaosController < ApplicationController
  before_action :set_tipo_notificacao, only: [:show, :edit, :update, :destroy]

  # GET /tipo_notificacaos
  # GET /tipo_notificacaos.json
  def index
    @tipo_notificacaos = TipoNotificacao.all
  end

  # GET /tipo_notificacaos/1
  # GET /tipo_notificacaos/1.json
  def show
  end

  # GET /tipo_notificacaos/new
  def new
    @tipo_notificacao = TipoNotificacao.new
  end

  # GET /tipo_notificacaos/1/edit
  def edit
  end

  # POST /tipo_notificacaos
  # POST /tipo_notificacaos.json
  def create
    @tipo_notificacao = TipoNotificacao.new(tipo_notificacao_params)

    respond_to do |format|
      if @tipo_notificacao.save
        format.html { redirect_to @tipo_notificacao, notice: 'Tipo notificacao was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_notificacao }
      else
        format.html { render :new }
        format.json { render json: @tipo_notificacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_notificacaos/1
  # PATCH/PUT /tipo_notificacaos/1.json
  def update
    respond_to do |format|
      if @tipo_notificacao.update(tipo_notificacao_params)
        format.html { redirect_to @tipo_notificacao, notice: 'Tipo notificacao was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_notificacao }
      else
        format.html { render :edit }
        format.json { render json: @tipo_notificacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_notificacaos/1
  # DELETE /tipo_notificacaos/1.json
  def destroy
    @tipo_notificacao.destroy
    respond_to do |format|
      format.html { redirect_to tipo_notificacaos_url, notice: 'Tipo notificacao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_notificacao
      @tipo_notificacao = TipoNotificacao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_notificacao_params
      params.require(:tipo_notificacao).permit(:qtd_dias, :mensagem, :ativo)
    end
end
