class AddCriadorToEstabelecimentosUsuarios < ActiveRecord::Migration
  def change
    add_column :estabelecimentos_usuarios, :ic_criador, :boolean
  end
end
