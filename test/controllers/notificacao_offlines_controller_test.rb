require 'test_helper'

class NotificacaoOfflinesControllerTest < ActionController::TestCase
  setup do
    @notificacao_offline = notificacao_offlines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notificacao_offlines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notificacao_offline" do
    assert_difference('NotificacaoOffline.count') do
      post :create, notificacao_offline: { data_notificacao: @notificacao_offline.data_notificacao, produto_id: @notificacao_offline.produto_id, usuario_id: @notificacao_offline.usuario_id }
    end

    assert_redirected_to notificacao_offline_path(assigns(:notificacao_offline))
  end

  test "should show notificacao_offline" do
    get :show, id: @notificacao_offline
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notificacao_offline
    assert_response :success
  end

  test "should update notificacao_offline" do
    patch :update, id: @notificacao_offline, notificacao_offline: { data_notificacao: @notificacao_offline.data_notificacao, produto_id: @notificacao_offline.produto_id, usuario_id: @notificacao_offline.usuario_id }
    assert_redirected_to notificacao_offline_path(assigns(:notificacao_offline))
  end

  test "should destroy notificacao_offline" do
    assert_difference('NotificacaoOffline.count', -1) do
      delete :destroy, id: @notificacao_offline
    end

    assert_redirected_to notificacao_offlines_path
  end
end
