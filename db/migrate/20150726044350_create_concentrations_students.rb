class CreateConcentrationsStudents < ActiveRecord::Migration
	def change
		create_table :concentrations_students, :id => false do |t|
			t.references :concentration, null: false
			t.references :student, null: false
		end
		
		
		# Adding the index can massively speed up join tables. Don't use the
		# unique if you allow duplicates.
		add_index(:concentrations_students, [:concentration_id, :student_id])
	end
end
