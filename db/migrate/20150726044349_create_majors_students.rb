class CreateMajorsStudents < ActiveRecord::Migration
	def change
		create_table :majors_students, :id => false do |t|
			t.references :major, null: false
			t.references :student, null: false
		end
		
		
		# Adding the index can massively speed up join tables. Don't use the
		# unique if you allow duplicates.
		add_index(:majors_students, [:major_id, :student_id])
	end
end
