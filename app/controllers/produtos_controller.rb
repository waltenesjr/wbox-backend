class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /produtos
  # GET /produtos.json
  def index
    @produtos = Produto.all
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    @produto = Produto.new(produto_params)
    @usuario = Usuario.find(params[:produto][:usuario][:usuario_id])

    @produto.usuarios << @usuario

    respond_to do |format|
      if @produto.save
        format.html { redirect_to @produto, notice: 'Produto was successfully created.' }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to @produto, notice: 'Produto was successfully updated.' }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to produtos_url, notice: 'Produto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def listar_vencidos
    @estabelececimento = Estabelecimento.find(params[:estabelecimento_id])
    @produtos = @estabelececimento.produtos.where("data_vencimento < (?)", Date.today).order(:data_vencimento)
    render :json => @produtos
  end
  
  def listar_a_vencer
    @estabelececimento = Estabelecimento.find(params[:estabelecimento_id])
    @produtos = @estabelececimento.produtos.where("data_vencimento >= (?)", Date.today).order(:data_vencimento)
    render :json => @produtos
  end

  def relatorio
    @usuario = Usuario.find(params[:usuario_id])

    if params[:estabelecimento_id].present? && params[:estabelecimento_id].to_i > 0
        @estabelecimento = Estabelecimento.find(params[:estabelecimento_id])
    end

    if params[:periodo_inicio].present?
      @periodo_inicio = params[:periodo_inicio].to_date
    end

    if params[:periodo_fim].present?
      @periodo_fim = params[:periodo_fim].to_date
    end

    respond_to do |format|
      format.html

      format.pdf { render pdf: "relatorio_produtos", encoding: "UTF-8",
        header: {center: "WARNINGBOX"},
        footer: { center: "[page] de [topage]" }
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_params
      params.require(:produto).permit(:imagem, :data_vencimento, :estabelecimento_id, :categoria, :codigo_de_barras, :quantidade, :valor)
    end
end
