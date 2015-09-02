class AddStudentsWidgetsAssociation < ActiveRecord::Migration
	def change
		create_table :students_widgets, :id => false do |t|
			t.references :student, null: false
			t.references :widget, null: false
		end
		add_index(:students_widgets, [:student_id, :widget_id])
	end
end
