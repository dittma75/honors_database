class Concentration < ActiveRecord::Base
  attr_accessible :concentration
	
	#Cardinality
	has_and_belongs_to_many :students
	
	#Validation
	validates :concentration, presence: true
end
