class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
			t.string :CRN, null: false, limit: 5
			t.string :course_name, null: false
			t.string :subject, null: false
			t.integer :course_ID, null: false
			t.integer :section_ID, null: false
			t.boolean :is_honors, null: false
      t.timestamps
    end
  end
end
