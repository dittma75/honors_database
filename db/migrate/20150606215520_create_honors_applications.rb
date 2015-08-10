class CreateHonorsApplications < ActiveRecord::Migration
  def change
    create_table :honors_applications do |t|
			t.integer :combined_SAT, null: false
			t.integer :math_SAT, null: false
			t.integer :writing_SAT, null: false
			t.integer :critical_reading_SAT, null: false
			t.integer :essay_one, null: false
			t.integer :essay_two, null: false
			t.integer :recommendation, null: false
			t.decimal :high_school_GPA, null: false, scale: 2, precision: 3
      t.timestamps
			
			#One-to-many ids
			t.references :student, null: false
    end
  end
end
