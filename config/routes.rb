Rails.application.routes.draw do
  resources :parametros
  resources :tipo_notificacaos
  resources :notificacao_offlines
  resources :usuario_periodos
  resources :usuarios
  resources :estabelecimentos
  resources :produtos
  
  get 'notificacoes/notificacao' => 'notificacoes#notificacao'

  get 'notificacoes/existe_notificacao' => 'notificacoes#existe_notificacao'

  get 'notificacoes/efetivar_notificacao_offline' => 'notificacoes#efetivar_notificacao_offline'

  get 'notificacoes/enviar_notificacao_push' => 'notificacoes#enviar_notificacao_push'

  get 'notificacoes/listar_alertas_do_dia' => 'notificacoes#listar_alertas_do_dia'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'produtos#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'vencidos' => 'produtos#listar_vencidos'
  
  get 'avencer' => 'produtos#listar_a_vencer'

  get 'consultarStatusUsuarioPorEmail' => 'usuarios#consultarStatusPorEmail'
  
  get 'consultarUsuarioPorEmail' => 'usuarios#consultarPorEmail'

  get 'consultarSenhaPorEmail' => 'usuarios#consultarSenhaPorEmail'

  get 'autenticarUsuario' => 'usuarios#autenticarUsuario'
  
  get 'consultarEstabelecimentosPorUsuario' => 'estabelecimentos#consultarPorUsuario'

  get 'consultarEstabelecimentoPorNome' => 'estabelecimentos#consultarPorNome'

  get 'compartilharEstabelecimento' => 'estabelecimentos#compartilharEstabelecimento'

  get 'transferirEstabelecimento' => 'estabelecimentos#transferirEstabelecimento'

  get 'consultarParametroPorNome' => 'parametros#consultarPorNome'

  get 'relatorioProdutos' => 'produtos#relatorio'

  post 'excluirCompartilhamento' => 'estabelecimentos#excluirCompartilhamento'

  get 'listarEstabelecimentosCompartilhados' => 'estabelecimentos#listarEstabelecimentosCompartilhados'

  get 'enviarEmailRecuperacaoSenha' => 'usuarios#enviarEmailRecuperacaoSenha'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
