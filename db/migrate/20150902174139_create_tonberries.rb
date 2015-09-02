class CreateTonberries < ActiveRecord::Migration
	def change
		create_table :tonberries do |t|
			t.string :clothing
			t.string :item
			t.string :job
			t.string :command
			t.string :eye_color

			t.timestamps
		end
	end
end
