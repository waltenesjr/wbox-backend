class Estabelecimento < ActiveRecord::Base
    has_many :estabelecimentos_usuarios
    has_many :usuarios, :through => :estabelecimentos_usuarios
    
    has_many :produtos
end
