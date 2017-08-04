require 'test_helper'

class UsuarioPeriodosControllerTest < ActionController::TestCase
  setup do
    @usuario_periodo = usuario_periodos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usuario_periodos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usuario_periodo" do
    assert_difference('UsuarioPeriodo.count') do
      post :create, usuario_periodo: { fim_periodo: @usuario_periodo.fim_periodo, inicio_periodo: @usuario_periodo.inicio_periodo, situacao: @usuario_periodo.situacao, usuario_id: @usuario_periodo.usuario_id }
    end

    assert_redirected_to usuario_periodo_path(assigns(:usuario_periodo))
  end

  test "should show usuario_periodo" do
    get :show, id: @usuario_periodo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usuario_periodo
    assert_response :success
  end

  test "should update usuario_periodo" do
    patch :update, id: @usuario_periodo, usuario_periodo: { fim_periodo: @usuario_periodo.fim_periodo, inicio_periodo: @usuario_periodo.inicio_periodo, situacao: @usuario_periodo.situacao, usuario_id: @usuario_periodo.usuario_id }
    assert_redirected_to usuario_periodo_path(assigns(:usuario_periodo))
  end

  test "should destroy usuario_periodo" do
    assert_difference('UsuarioPeriodo.count', -1) do
      delete :destroy, id: @usuario_periodo
    end

    assert_redirected_to usuario_periodos_path
  end
end
