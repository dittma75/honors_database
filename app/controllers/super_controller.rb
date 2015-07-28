class SuperController < ApplicationController
	def index(klass)
		@class = klass
		@objects = klass.all
	end
	
	def show(klass)
		@object = klass.find(params[:id])
	end
	
	def new(klass)
		@object = klass.new
	end
	
	def create(klass)
		@object = klass.new(params[klass.name.underscore.to_sym])
		if (@object.save)
			add_associations(klass)
			redirect_to @object
		else
			render 'new'
		end
	end
	
	def edit(klass)
		@object = klass.find(params[:id])
	end
	
	def update(klass)
		@object = klass.find(params[:id])
		if (@object.update_attributes(params[klass.name.underscore.to_sym]))
			add_associations(klass)
			redirect_to action: 'show', id: @object.id
		else
			render 'edit'
		end
	end
	
	def destroy(klass)
		@object = klass.find(params[:id])
		@object.destroy
		
		redirect_to action: 'index'
	end
	
	private
	
	def add_associations(klass)
		mtm_associations = klass.reflect_on_all_associations(:has_many) +
			klass.reflect_on_all_associations(:has_and_belongs_to_many)
		mtm_associations.each do |assoc|
			key = params[assoc.association_foreign_key.to_sym]
			unless (key.blank?)
				new_association = assoc.class_name.constantize.find(key)
				unless (new_association.blank?)
					add_association(
						@object.send(assoc.plural_name),
						key,
						new_association
					)
				end
			end
		end
	end

################################################################################	
# PROBABLY USELESS - HERE UNTIL TESTING IS DONE	
#	def add_reverse_associations(klass)
#		mtm = klass.reflect_on_all_associations(:has_many_and_belongs_to_many)
#		mtm.each do |assoc|
#			owner_key = params[assoc.association_foreign_key.to_sym]
#			unless (owner_key.blank?)
#				owner_object = assoc.class_name.constantize.find(owner_key)
#				unless (owner_object.blank?)
#					add_association(
#						owner_object.send(klass.name.underscore.to_s.pluralize),
#						@object.id,
#						@object
#					)
#				end
#			end
#		end
#	end
################################################################################

	def add_association(current_associations, new_assoc_key, new_assoc)
		unless (new_assoc_key.blank?)
			unless (current_associations.include?(new_assoc))
				current_associations << new_assoc
			end
		end
	end
end
