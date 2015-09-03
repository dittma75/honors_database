class DeleteTonberries < ActiveRecord::Migration
	def up
		drop_table :tonberries	end
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
