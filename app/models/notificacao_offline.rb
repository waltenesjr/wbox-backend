class NotificacaoOffline < ActiveRecord::Base
  belongs_to :produto
  belongs_to :usuario
end
