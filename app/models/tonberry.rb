class Tonberry < ActiveRecord::Base
	attr_protected :id, :created_at, :updated_at
	#ASSOCIATIONS
	#VALIDATIONS
	def name
		return "#{self.job}"
	end
end