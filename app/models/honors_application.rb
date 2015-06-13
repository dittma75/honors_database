class HonorsApplication < ActiveRecord::Base
		attr_accessible :sat, :essay_one, :essay_two, :recommendation, :hs_gpa
	#Cardinality	
	belongs_to :student
	
	#Valdiation
	validates :sat, presence: true
	validates :essay_one, presence: true
	validates :essay_two, presence: true
	validates :hs_gpa, presence: true
	validates :recommendation, presence: true
end
