class AddCamposToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :categoria, :boolean
    add_column :usuarios, :codigo_de_barras, :boolean
    add_column :usuarios, :quantidade, :boolean
    add_column :usuarios, :valor, :boolean
  end
end
