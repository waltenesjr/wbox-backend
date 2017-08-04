require 'test_helper'

class EstabelecimentosControllerTest < ActionController::TestCase
  setup do
    @estabelecimento = estabelecimentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estabelecimentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estabelecimento" do
    assert_difference('Estabelecimento.count') do
      post :create, estabelecimento: { nome: @estabelecimento.nome }
    end

    assert_redirected_to estabelecimento_path(assigns(:estabelecimento))
  end

  test "should show estabelecimento" do
    get :show, id: @estabelecimento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estabelecimento
    assert_response :success
  end

  test "should update estabelecimento" do
    patch :update, id: @estabelecimento, estabelecimento: { nome: @estabelecimento.nome }
    assert_redirected_to estabelecimento_path(assigns(:estabelecimento))
  end

  test "should destroy estabelecimento" do
    assert_difference('Estabelecimento.count', -1) do
      delete :destroy, id: @estabelecimento
    end

    assert_redirected_to estabelecimentos_path
  end
end
