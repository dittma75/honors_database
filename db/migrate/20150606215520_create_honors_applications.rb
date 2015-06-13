class CreateHonorsApplications < ActiveRecord::Migration
  def change
    create_table :honors_applications do |t|
			t.integer :sat, null: false
			t.integer :essay_one, null: false
			t.integer :essay_two, null: false
			t.integer :recommendation, null: false
			t.decimal :hs_gpa, null: false, scale: 2, precision: 3
      t.timestamps
    end
  end
end
