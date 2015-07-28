class Major < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	has_and_belongs_to_many :students
	
	#Validation
	validates :major, presence: true
	
	def name
		return "#{self.major}"
	end
end
