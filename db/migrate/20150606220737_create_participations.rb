class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
			t.decimal :service, null: false, scale: 2, precision: 10
			t.decimal :activity, null: false, scale: 2, precision: 10
      t.timestamps
			
			#One-to-many ids
			t.references :student, null: false
			t.references :semester, null: false
    end
  end
end
