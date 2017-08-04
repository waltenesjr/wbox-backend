class CreateParametros < ActiveRecord::Migration
  def change
    create_table :parametros do |t|
      t.string :nome
      t.string :valor

      t.timestamps null: false
    end
  end
end
