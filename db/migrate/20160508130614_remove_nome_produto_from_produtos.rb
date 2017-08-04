class RemoveNomeProdutoFromProdutos < ActiveRecord::Migration
  def change
    remove_column :produtos, :nomeProduto, :string
    remove_column :produtos, :fotoProduto, :binary
    remove_reference :produtos, :marca, index: true, foreign_key: true
  end
end
