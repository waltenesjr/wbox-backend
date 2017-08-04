class AddSenhaToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :nome, :string
    add_column :usuarios, :senha, :string
    add_column :usuarios, :ausente, :boolean
  end
end
