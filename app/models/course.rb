class Course < ActiveRecord::Base
  attr_accessible :crn, :course_id, :section_id, :is_honors
	
	#Cardinality
	has_and_belongs_to_many :students
	belongs_to :semester
	
	#Validation
	validates :crn, presence: true, uniqueness: true, length: {is: 5}
	validates :course_id, presence: true, numericality: {only_integer: true}
	validates :section_id, presence: true, numericality: {only_integer: true}
	validates :is_honors, presence: true
end
