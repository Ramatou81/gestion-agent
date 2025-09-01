class AddManagerToAgents < ActiveRecord::Migration[7.0]
  def change
    add_reference :agents, :manager, foreign_key: { to_table: :agents }, null: true
  end
end
