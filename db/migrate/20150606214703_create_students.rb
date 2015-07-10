class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
			t.string :banner_ID, null: false, limit: 9
			t.string :first_name, null: false
			t.string :last_name, null: false
			t.string :email, null: false
			t.boolean :is_rowan, null: false
			t.boolean :is_honors, null: false
			t.string :reason_not_honors, null: false
			t.string :street, null: false
			t.string :city, null: false
			t.string :state, null: false, limit: 2
			t.string :enroll_session, null: false
			t.integer :enroll_year, null: false
			t.string :graduation_session
			t.integer :graduation_year
      t.timestamps
    end
  end
end
