class CreateUsuarioPeriodos < ActiveRecord::Migration
  def change
    create_table :usuario_periodos do |t|
      t.references :usuario, index: true, foreign_key: true
      t.date :inicio_periodo
      t.date :fim_periodo
      t.string :situacao 

      t.timestamps null: false
    end
  end
end
