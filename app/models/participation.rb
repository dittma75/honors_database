class Participation < ActiveRecord::Base
  attr_accessible :service, :activity
	
	#Cardinality
	belongs_to :student
	belongs_to :semester
	
	#Validation
	validates :service, presence: true, numericality: true
	validates :activity, presence: true, numericality: true
end
