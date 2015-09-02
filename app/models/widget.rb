class Widget < ActiveRecord::Base
	attr_protected :id, :created_at, :updated_at
	#ASSOCIATIONS
	belongs_to :course
	has_and_belongs_to_many :students
	#VALIDATIONS
	validates :_name, presence: true
	def name
		return "#{self._name}, #{self.color}"
	end
end
