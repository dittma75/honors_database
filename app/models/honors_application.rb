class HonorsApplication < ActiveRecord::Base
	attr_protected :id, :created_at, :updated_at
	
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
		unless (self.student.nil?)
			return "#{self.student.name} (Submitted: #{self.created_at})"
		end
		return "Submitted: #{self.created_at}"
	end
end
