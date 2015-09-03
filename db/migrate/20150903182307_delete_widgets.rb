class DeleteWidgets < ActiveRecord::Migration
	def up
		drop_table :widgets
	end
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
