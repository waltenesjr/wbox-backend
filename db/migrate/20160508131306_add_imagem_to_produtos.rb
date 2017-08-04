class AddImagemToProdutos < ActiveRecord::Migration
  def change
    add_column :produtos, :imagem, :binary
    add_column :produtos, :data_vencimento, :date
    add_reference :produtos, :estabelecimento, index: true, foreign_key: true
  end
end
