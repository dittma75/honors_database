class StudentsController < ApplicationController
	def index
		@students = Student.all
	end
	
	def show
		@student = Student.find(params[:id])
	end
	
	def new
		@student = Student.new
	end
	
	def create
		@student = Student.new(params[:student])
		@student.is_honors = true
		@student.is_rowan = true
		if (@student.save)
			redirect_to @student
		else
			render 'new'
		end
	end
	
	def edit
		@student = Student.find(params[:id])
	end
	
	def update
		@student = Student.find(params[:id])
		if (@student.update_attributes(params[:student]))
			redirect_to action: 'show', id: @student.id
		end
	end
	
	def destroy
		@student = Student.find(params[:id])
		@student.destroy
	end
end
