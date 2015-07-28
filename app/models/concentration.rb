class Concentration < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	has_and_belongs_to_many :students
	
	#Validation
	validates :concentration, presence: true
	
	def name
		return "#{self.concentration}"
	end
end
