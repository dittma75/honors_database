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
		end
	end
	
	def destroy(klass)
		@object = klass.find(params[:id])
		@object.destroy
		
		redirect_to action: 'index'
	end
	
	private
	def underscore
		word = self.dup
		word.gsub!(/::/, '/')
		word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
		word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
		word.tr!("-", "_")
		word.downcase!
		return word
  end
end
