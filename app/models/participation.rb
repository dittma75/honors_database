class Participation < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	belongs_to :student
	belongs_to :semester
	
	#Validation
	validates :service, presence: true, numericality: true
	validates :activity, presence: true, numericality: true
	
	def name
		if (self.student.nil?)
			participation_name = "Unassociatied participation for "
		else
			participation_name = "#{self.student.name} for "
		end
		
		if (self.semester.nil?)
			participation_name += "unknown semester"
		else
			participation_name += "#{self.semester.name}"
		end
		
		return participation_name
	end
end
