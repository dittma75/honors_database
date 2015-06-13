class CreateMinors < ActiveRecord::Migration
  def change
    create_table :minors do |t|
			t.string :minor, null: false
      t.timestamps
    end
  end
end
