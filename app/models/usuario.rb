class Usuario < ActiveRecord::Base
    has_many :estabelecimentos_usuarios, :dependent => :delete_all
    has_many :estabelecimentos, :through => :estabelecimentos_usuarios

    has_and_belongs_to_many :produtos, :dependent => :delete_all
    has_many :notificacaoOfflines
    has_many :usuarioPeriodos, :dependent => :delete_all

    def possui_periodo_valido
    	count = usuarioPeriodos.where("inicio_periodo <= ? and fim_periodo >= ? and situacao in (?)", Date.today, Date.today, ['P','G']).count
    	count > 0
    end
end
