class Student < ActiveRecord::Base
	attr_accessible :banner_ID, :last_name, :first_name, :is_rowan, :email,
									:street, :city, :state, :enroll_session, :enroll_year,
									:graduation_session, :graduation_year, :is_honors,
									:reason_not_honors
	#Cardinality
	has_many :honors_applications
	has_many :participations
	has_and_belongs_to_many :majors
	has_and_belongs_to_many :minors
  has_and_belongs_to_many :concentrations
	has_and_belongs_to_many :courses
	
	#Validations
	validates :banner_ID, uniqueness: true, presence: true, length: {is: 9}
	validates :last_name, presence: true
	validates :first_name, presence: true
	validates :email, presence: true, email: true
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true, length: {is: 2}
	validates :enroll_session, presence: true
	validates :enroll_year, presence: true, numericality: {only_integer: true}
	validates :graduation_year, numericality: {only_integer: true}
	
	def name
		return "#{self.last_name}, #{self.first_name}"
	end
end
