class Semester < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
	
	#Cardinality
	has_many :courses
	has_many :participations
	#ASSOCIATIONS
	#VALIDATIONS
	validates :year, presence: true, numericality: {only_integer: true}
	validates :session, presence: true
	
	def name
		return "#{self.session} #{self.year}"
	end
end
