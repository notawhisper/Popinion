class CreateCodeNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :code_numbers do |t|
      t.integer :code_number, null: false
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
