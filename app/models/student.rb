class Student < ActiveRecord::Base
	attr_accessible :banner_id, :lname, :fname, :is_rowan, :email, :street,
									:city, :state, :enroll_session, :enroll_year, :grad_session,
									:grad_year, :is_honors, :reason_not_honors
	#Cardinality
	has_many :honors_applications
	has_many :participations
	has_and_belongs_to_many :majors
	has_and_belongs_to_many :minors
	has_and_belongs_to_many :concentrations
	has_and_belongs_to_many :courses
	
	#Validations
	validates :banner_id, uniqueness: true, presence: true, length: {is: 9}
	validates :lname, presence: true
	validates :fname, presence: true
	validates :is_rowan, presence: true
	validates :email, presence: true, email: true
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true, length: {is: 2}
	validates :enroll_session, presence: true
	validates :enroll_year, presence: true, numericality: {only_integer: true}
	validates :grad_year, numericality: {only_integer: true}
	validates :is_honors, presence: true
end
