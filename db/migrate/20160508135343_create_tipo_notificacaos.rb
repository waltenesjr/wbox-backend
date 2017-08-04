class CreateTipoNotificacaos < ActiveRecord::Migration
  def change
    create_table :tipo_notificacaos do |t|
      t.integer :qtd_dias
      t.string :mensagem
      t.boolean :ativo

      t.timestamps null: false
    end
  end
end
