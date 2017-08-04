class CreateJoinTableUsuarioProduto < ActiveRecord::Migration
  def change
    create_join_table :usuarios, :produtos do |t|
      # t.index [:usuario_id, :produto_id]
      # t.index [:produto_id, :usuario_id]
    end
  end
end
