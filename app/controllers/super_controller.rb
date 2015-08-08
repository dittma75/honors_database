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
		otm_associations = klass.reflect_on_all_associations(:has_many)
		mtm_associations = klass.reflect_on_all_associations(:has_and_belongs_to_many)
		otm_associations.each do |assoc|
			param_id = "#{assoc.plural_name}_id"
		  key = params[param_id.to_sym]
			unless (key.blank?)
				class_name = assoc.plural_name.singularize.gsub!("_", " ")
				new_association = class_name.constantize.find(key)
				unless (new_association.blank?)
					add_association(
						@object.send(assoc.plural_name),
						key,
						new_association
					)
				end
			end
		end
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

	def add_association(current_associations, new_assoc_key, new_assoc)
		unless (new_assoc_key.blank?)
			unless (current_associations.include?(new_assoc))
				current_associations << new_assoc
			end
		end
	end
end
