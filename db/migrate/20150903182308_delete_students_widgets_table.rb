class DeleteStudentsWidgetsTable < ActiveRecord::Migration
	def up
		drop_table :students_widgets
	end
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
