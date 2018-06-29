class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :operacao
      t.integer :qtd
      t.references :material, foreign_key: true

      t.timestamps
    end
  end
end
