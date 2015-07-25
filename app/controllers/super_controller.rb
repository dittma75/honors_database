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
end
