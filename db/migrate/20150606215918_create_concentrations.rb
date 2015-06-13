class CreateConcentrations < ActiveRecord::Migration
  def change
    create_table :concentrations do |t|
			t.string :concentration, null: false
      t.timestamps
    end
  end
end
