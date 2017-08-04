class UsuarioPeriodosController < ApplicationController
  before_action :set_usuario_periodo, only: [:show, :edit, :update, :destroy]

  # GET /usuario_periodos
  # GET /usuario_periodos.json
  def index
    @usuario_periodos = UsuarioPeriodo.all
  end

  # GET /usuario_periodos/1
  # GET /usuario_periodos/1.json
  def show
  end

  # GET /usuario_periodos/new
  def new
    @usuario_periodo = UsuarioPeriodo.new
  end

  # GET /usuario_periodos/1/edit
  def edit
  end

  # POST /usuario_periodos
  # POST /usuario_periodos.json
  def create
    @usuario_periodo = UsuarioPeriodo.new(usuario_periodo_params)

    respond_to do |format|
      if @usuario_periodo.save
        format.html { redirect_to @usuario_periodo, notice: 'Usuario periodo was successfully created.' }
        format.json { render :show, status: :created, location: @usuario_periodo }
      else
        format.html { render :new }
        format.json { render json: @usuario_periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuario_periodos/1
  # PATCH/PUT /usuario_periodos/1.json
  def update
    respond_to do |format|
      if @usuario_periodo.update(usuario_periodo_params)
        format.html { redirect_to @usuario_periodo, notice: 'Usuario periodo was successfully updated.' }
        format.json { render :show, status: :ok, location: @usuario_periodo }
      else
        format.html { render :edit }
        format.json { render json: @usuario_periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuario_periodos/1
  # DELETE /usuario_periodos/1.json
  def destroy
    @usuario_periodo.destroy
    respond_to do |format|
      format.html { redirect_to usuario_periodos_url, notice: 'Usuario periodo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario_periodo
      @usuario_periodo = UsuarioPeriodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_periodo_params
      params.require(:usuario_periodo).permit(:usuario_id, :inicio_periodo, :fim_periodo, :situacao)
    end
end
