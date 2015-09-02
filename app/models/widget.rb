class Widget < ActiveRecord::Base
	attr_protected :id, :created_at, :updated_at
	#ASSOCIATIONS
	#VALIDATIONS
	def name
		return "#{self._name}, #{self.color}"
	end
end