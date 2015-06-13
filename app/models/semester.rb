class Semester < ActiveRecord::Base
  attr_accessible :year, :session
	
	#Cardinality
	has_many :courses
	has_many :participations
	
	#Validation
	validates :year, presence: true, numericality: {only_integer: true}
	validates :session, presence: true
end
