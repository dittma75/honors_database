# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150903110116) do

  create_table "concentrations", :force => true do |t|
    t.string   "concentration", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "concentrations_students", :id => false, :force => true do |t|
    t.integer "concentration_id", :null => false
    t.integer "student_id",       :null => false
  end

  add_index "concentrations_students", ["concentration_id", "student_id"], :name => "index_concentrations_students_on_concentration_id_and_student_id"

  create_table "courses", :force => true do |t|
    t.string   "CRN",         :limit => 5, :null => false
    t.string   "course_name",              :null => false
    t.string   "subject",                  :null => false
    t.integer  "course_ID",                :null => false
    t.integer  "section_ID",               :null => false
    t.boolean  "is_honors",                :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "semester_id",              :null => false
  end

  create_table "courses_students", :id => false, :force => true do |t|
    t.integer "course_id",  :null => false
    t.integer "student_id", :null => false
  end

  add_index "courses_students", ["course_id", "student_id"], :name => "index_courses_students_on_course_id_and_student_id"

  create_table "honors_applications", :force => true do |t|
    t.integer  "combined_SAT",                                       :null => false
    t.integer  "math_SAT",                                           :null => false
    t.integer  "writing_SAT",                                        :null => false
    t.integer  "critical_reading_SAT",                               :null => false
    t.integer  "essay_one",                                          :null => false
    t.integer  "essay_two",                                          :null => false
    t.integer  "recommendation",                                     :null => false
    t.decimal  "high_school_GPA",      :precision => 3, :scale => 2, :null => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "student_id",                                         :null => false
  end

  create_table "majors", :force => true do |t|
    t.string   "major",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "majors_students", :id => false, :force => true do |t|
    t.integer "major_id",   :null => false
    t.integer "student_id", :null => false
  end

  add_index "majors_students", ["major_id", "student_id"], :name => "index_majors_students_on_major_id_and_student_id"

  create_table "minors", :force => true do |t|
    t.string   "minor",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "minors_students", :id => false, :force => true do |t|
    t.integer "minor_id",   :null => false
    t.integer "student_id", :null => false
  end

  add_index "minors_students", ["minor_id", "student_id"], :name => "index_minors_students_on_minor_id_and_student_id"

  create_table "participations", :force => true do |t|
    t.decimal  "service",     :precision => 10, :scale => 2, :null => false
    t.decimal  "activity",    :precision => 10, :scale => 2, :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "student_id",                                 :null => false
    t.integer  "semester_id",                                :null => false
  end

  create_table "semesters", :force => true do |t|
    t.integer  "year"
    t.string   "session"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "banner_ID",          :limit => 9, :null => false
    t.string   "first_name",                      :null => false
    t.string   "last_name",                       :null => false
    t.string   "email",                           :null => false
    t.boolean  "is_rowan",                        :null => false
    t.boolean  "is_honors",                       :null => false
    t.string   "reason_not_honors",               :null => false
    t.string   "street",                          :null => false
    t.string   "city",                            :null => false
    t.string   "state",              :limit => 2, :null => false
    t.string   "enroll_session",                  :null => false
    t.integer  "enroll_year",                     :null => false
    t.string   "graduation_session"
    t.integer  "graduation_year"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "students_widgets", :id => false, :force => true do |t|
    t.integer "student_id", :null => false
    t.integer "widget_id",  :null => false
  end

  add_index "students_widgets", ["student_id", "widget_id"], :name => "index_students_widgets_on_student_id_and_widget_id"

  create_table "widgets", :force => true do |t|
    t.string   "_name"
    t.string   "size"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  add_index "widgets", ["course_id"], :name => "index_widgets_on_course_id"

end
