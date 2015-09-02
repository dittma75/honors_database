class CreateWidgets < ActiveRecord::Migration
	def change
		create_table :widgets do |t|
			t.string :_name
			t.string :size
			t.string :color

			t.timestamps
		end
	end
end
