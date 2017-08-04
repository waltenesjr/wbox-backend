class Produto < ActiveRecord::Base
  belongs_to :estabelecimento
  has_and_belongs_to_many :usuarios
  has_many :notificacaoOfflines, :dependent => :delete_all

  def diferencaDeDias
     (data_vencimento - Date.today).to_i
  end
  
  def as_json(options={})
     super({ methods: [:diferencaDeDias]})
  end
  
end
