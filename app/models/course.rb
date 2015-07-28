class Course < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	has_and_belongs_to_many :students
	belongs_to :semester
	
	#Validation
	validates :CRN, presence: true, uniqueness: true, length: {is: 5}
	validates :course_ID, presence: true, numericality: {only_integer: true}
	validates :section_ID, presence: true, numericality: {only_integer: true}
	validates :is_honors, presence: true
	
	def name
		return "#{self.CRN}"
	end
end
