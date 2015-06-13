class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
			t.integer :year
			t.string :session
      t.timestamps
    end
  end
end
