class AddIdpushToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :idpush, :string
  end
end
