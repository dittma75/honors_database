class CreateCoursesStudents < ActiveRecord::Migration
	def change
		create_table :courses_students, :id => false do |t|
			t.references :course, null: false
			t.references :student, null: false
		end
		
		
		# Adding the index can massively speed up join tables. Don't use the
		# unique if you allow duplicates.
		add_index(:courses_students, [:course_id, :student_id])
	end
end
