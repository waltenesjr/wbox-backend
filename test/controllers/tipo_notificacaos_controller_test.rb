require 'test_helper'

class TipoNotificacaosControllerTest < ActionController::TestCase
  setup do
    @tipo_notificacao = tipo_notificacaos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_notificacaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_notificacao" do
    assert_difference('TipoNotificacao.count') do
      post :create, tipo_notificacao: { ativo: @tipo_notificacao.ativo, mensagem: @tipo_notificacao.mensagem, qtd_dias: @tipo_notificacao.qtd_dias }
    end

    assert_redirected_to tipo_notificacao_path(assigns(:tipo_notificacao))
  end

  test "should show tipo_notificacao" do
    get :show, id: @tipo_notificacao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_notificacao
    assert_response :success
  end

  test "should update tipo_notificacao" do
    patch :update, id: @tipo_notificacao, tipo_notificacao: { ativo: @tipo_notificacao.ativo, mensagem: @tipo_notificacao.mensagem, qtd_dias: @tipo_notificacao.qtd_dias }
    assert_redirected_to tipo_notificacao_path(assigns(:tipo_notificacao))
  end

  test "should destroy tipo_notificacao" do
    assert_difference('TipoNotificacao.count', -1) do
      delete :destroy, id: @tipo_notificacao
    end

    assert_redirected_to tipo_notificacaos_path
  end
end
