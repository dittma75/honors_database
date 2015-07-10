class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
			t.string :CRN, null: false, limit: 5
			t.integer :course_id, null: false
			t.integer :section_id, null: false
			t.boolean :is_honors, null: false
      t.timestamps
    end
  end
end
