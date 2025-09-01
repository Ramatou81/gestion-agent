class CreateAgents < ActiveRecord::Migration[8.0]
  def change
    create_table :agents do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :email, null: false
      t.string :phone
      t.date :birth_date
      t.string :address
      t.string :position
      t.date :hire_date
      t.string :status, default: "active"
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end

    add_index :agents, :email, unique: true
  end
end
