class AddCourseHasWidgetsAssociation < ActiveRecord::Migration
	def change
		add_column :widgets, :course_id, :integer
		add_index(:widgets, :course_id)
	end
end
