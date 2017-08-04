class AddCodigoRecuperacaoSenhaToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :codigoRecuperacaoSenha, :string
  end
end
