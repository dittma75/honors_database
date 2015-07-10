class HonorsApplication < ActiveRecord::Base
		attr_accessible :combined_SAT, :math_SAT, :critical_reading_SAT, 
										:writing_SAT, :essay_one, :essay_two, :recommendation,
										:high_school_GPA
	#Cardinality	
	belongs_to :student
	
	#Valdiation
	validates :sat, presence: true
	validates :essay_one, presence: true
	validates :essay_two, presence: true
	validates :hs_gpa, presence: true
	validates :recommendation, presence: true
end
