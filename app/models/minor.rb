class Minor < ActiveRecord::Base
  attr_accessible :minor
	
	#Cardinality
	has_and_belongs_to_many :students
	
	#Validation
	validates :minor, presence: true
	
	def name
		return "#{self.minor}"
	end
end
