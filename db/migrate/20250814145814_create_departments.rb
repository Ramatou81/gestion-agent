class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.text :description
      t.references :manager, foreign_key: { to_table: :agents }

      t.timestamps
    end
  end
end
