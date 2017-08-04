class CreateEstabelecimentosUsuarios < ActiveRecord::Migration
  def change
    create_table :estabelecimentos_usuarios, id: false do |t|
      t.belongs_to :estabelecimento, index: true
      t.belongs_to :usuario, index: true
    end
  end
end
