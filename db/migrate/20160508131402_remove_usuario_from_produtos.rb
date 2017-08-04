class RemoveUsuarioFromProdutos < ActiveRecord::Migration
  def change
    remove_reference :produtos, :usuario, index: true, foreign_key: true
  end
end
