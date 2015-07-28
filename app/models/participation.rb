class Participation < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	belongs_to :student
	belongs_to :semester
	
	#Validation
	validates :service, presence: true, numericality: true
	validates :activity, presence: true, numericality: true
	
	def name
		return "#{self.student.name} for #{self.semester.name}"
	end
end
