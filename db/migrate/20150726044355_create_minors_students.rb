class CreateMinorsStudents < ActiveRecord::Migration
	def change
		create_table :minors_students, :id => false do |t|
			t.references :minor, null: false
			t.references :student, null: false
		end
		
		
		# Adding the index can massively speed up join tables. Don't use the
		# unique if you allow duplicates.
		add_index(:minors_students, [:minor_id, :student_id])
	end
end
