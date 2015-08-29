class Minor < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	has_and_belongs_to_many :students
	#ASSOCIATIONS
	#VALIDATIONS
	validates :minor, presence: true
	
	def name
		return "#{self.minor}"
	end
end
