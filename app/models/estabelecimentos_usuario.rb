class EstabelecimentosUsuario < ActiveRecord::Base
    belongs_to :estabelecimento
    belongs_to :usuario
end
