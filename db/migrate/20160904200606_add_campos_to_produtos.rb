class AddCamposToProdutos < ActiveRecord::Migration
  def change
    add_column :produtos, :categoria, :string
    add_column :produtos, :codigo_de_barras, :string
    add_column :produtos, :quantidade, :integer
    add_column :produtos, :valor, :decimal
  end
end
