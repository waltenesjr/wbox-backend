class CreateNotificacaoOfflines < ActiveRecord::Migration
  def change
    create_table :notificacao_offlines do |t|
      t.references :produto, index: true, foreign_key: true
      t.references :usuario, index: true, foreign_key: true
      t.date :data_notificacao

      t.timestamps null: false
    end
  end
end
