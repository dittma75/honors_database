class HonorsApplication < ActiveRecord::Base
		attr_accessible :combined_SAT, :math_SAT, :critical_reading_SAT, 
										:writing_SAT, :essay_one, :essay_two, :recommendation,
										:high_school_GPA
	#Cardinality	
	belongs_to :student
	
	#Valdiation
	validates :combined_SAT, presence: true
	validates :math_SAT, presence: true
	validates :critical_reading_SAT, presence: true
	validates :writing_SAT, presence: true
	validates :essay_one, presence: true
	validates :essay_two, presence: true
	validates :high_school_GPA, presence: true
	validates :recommendation, presence: true
	
	def name
		return "#{self.student.name} (Submitted: #{self.created_at})"
	end
end
