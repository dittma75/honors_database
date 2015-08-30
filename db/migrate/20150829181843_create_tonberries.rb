class CreateTonberries < ActiveRecord::Migration
	def change
		create_table :tonberries do |t|
			t.string :cloak
			t.string :name
			t.string :knife
			t.string :lantern
			t.string :frown

			t.timestamps
		end
	end
end
