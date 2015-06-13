class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
			t.decimal :service, null: false, scale: 2, precision: 10
			t.decimal :activity, null: false, scale: 2, precision: 10
      t.timestamps
    end
  end
end
