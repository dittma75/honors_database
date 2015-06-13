class Major < ActiveRecord::Base
  attr_accessible :major
	
	#Cardinality
	has_and_belongs_to_many :students
	
	#Validation
	validates :major, presence: true
end
