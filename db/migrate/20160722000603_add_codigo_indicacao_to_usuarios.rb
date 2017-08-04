class AddCodigoIndicacaoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :codigo_indicador, :string
    add_column :usuarios, :codigo_indicacao, :string
  end
end
