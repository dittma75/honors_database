class Course < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	has_and_belongs_to_many :students
	belongs_to :semester
	#ASSOCIATIONS
	#VALIDATIONS
	validates :CRN, presence: true, uniqueness: true, length: {is: 5}
	validates :course_ID, presence: true, numericality: {only_integer: true}
	validates :section_ID, presence: true, numericality: {only_integer: true}
	
	def name
		return "#{self.course_name}"
	end
end
