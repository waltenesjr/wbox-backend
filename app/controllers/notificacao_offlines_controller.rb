class NotificacaoOfflinesController < ApplicationController
  before_action :set_notificacao_offline, only: [:show, :edit, :update, :destroy]

  # GET /notificacao_offlines
  # GET /notificacao_offlines.json
  def index
    @notificacao_offlines = NotificacaoOffline.all
  end

  # GET /notificacao_offlines/1
  # GET /notificacao_offlines/1.json
  def show
  end

  # GET /notificacao_offlines/new
  def new
    @notificacao_offline = NotificacaoOffline.new
  end

  # GET /notificacao_offlines/1/edit
  def edit
  end

  # POST /notificacao_offlines
  # POST /notificacao_offlines.json
  def create
    @notificacao_offline = NotificacaoOffline.new(notificacao_offline_params)

    respond_to do |format|
      if @notificacao_offline.save
        format.html { redirect_to @notificacao_offline, notice: 'Notificacao offline was successfully created.' }
        format.json { render :show, status: :created, location: @notificacao_offline }
      else
        format.html { render :new }
        format.json { render json: @notificacao_offline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notificacao_offlines/1
  # PATCH/PUT /notificacao_offlines/1.json
  def update
    respond_to do |format|
      if @notificacao_offline.update(notificacao_offline_params)
        format.html { redirect_to @notificacao_offline, notice: 'Notificacao offline was successfully updated.' }
        format.json { render :show, status: :ok, location: @notificacao_offline }
      else
        format.html { render :edit }
        format.json { render json: @notificacao_offline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notificacao_offlines/1
  # DELETE /notificacao_offlines/1.json
  def destroy
    @notificacao_offline.destroy
    respond_to do |format|
      format.html { redirect_to notificacao_offlines_url, notice: 'Notificacao offline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notificacao_offline
      @notificacao_offline = NotificacaoOffline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notificacao_offline_params
      params.require(:notificacao_offline).permit(:produto_id, :usuario_id, :data_notificacao)
    end
end
