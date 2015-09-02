require 'rake'
require 'task_helper.rb'
include TaskHelper

desc "add validation(s) to the given table's given attribute"
task :add_validation => :environment do
	ARGV.each { |a| task a.to_sym do ; end }
	ARGV.shift #get rid of task name form args
	# Make sure the args are in the order that Ruby expects.
	ARGV.map! {|arg| arg.downcase.singularize}
	add_validation(ARGV)
end

def add_validation(args)
	Dir.chdir(Rails.root)
	args[1] = TaskHelper.fix_reserved_words(args[1])
	if (args.count < 3)
		puts "Usage: rake add_validation model attribute validation\n"
		puts validation_list
	elsif (not File.file?("app/models/#{args[0]}.rb"))
		puts "Model #{args[0].classify} doesn't exist."
	elsif (not args[0].classify.constantize.column_names.include?(args[1]))
		puts "Attribute #{args[1]} doesn't exist for model #{args[0].classify}"
	else
		filename = "#{args.shift}.rb"
		attr = "#{args.shift}"
		path = "app/models/#{filename}"
		temp_file = Tempfile.new(filename)
		begin
			File.open(path, "r") do |f|
				f.each_line do |line|
					temp_file.puts line
					
					if (line.strip.eql?("#VALIDATIONS"))
						validation_line = 	"\tvalidates :#{attr}"
						args.each do |arg|
							case (arg)
							when 'present'
								validation_line += get_present
							when 'number'
								validation_line += get_number
							when 'integer'
								validation_line += get_integer
							when 'allow_blank'
								validation_line += get_blank
							when 'unique'
								validation_line += get_unique
							when 'email'
								validation_line += get_email
							else
								components = arg.split(':')
								if (components[0].eql?('length'))
									length_args = []
									if (components[1].include?(','))
										length_args = components[1].strip.split(',')
									else
										length_args = [components[1].strip]
									end
									options = []
									length_args.each do |l_arg|
										operator = l_arg.slice!(0,3)
										number = l_arg.to_i
										if (number > 0)
											case (operator)
											when 'min'
												options << "minimum: #{number}"
											when 'max'
												options << "maximum: #{number}"
											when 'eql'
												options << "is: #{number}"
											else
												puts "Operator #{operator} not recognized"
											end
										else
											puts "length specification must be a positive number"
										end
									end
									validation_line += get_length(options.join(', '))
								else
									puts "Argument #{arg} is invalid"
								end
							end
						end
						temp_file.puts validation_line
					end
				end
			end
			temp_file.close
			FileUtils.mv(temp_file.path, path)
		ensure
			temp_file.close
			temp_file.unlink
		end
		puts "Run 'rake db:migrate' to update the CMS application."
	end
end

def get_present
	return ", presence: true"
end

def get_number
	return ", numericality: true"
end

def get_integer
	return ", numericality: {only_integer: true}"
end

def get_blank
	return ", allow_blank: true"
end

def get_unique
	return ", uniqueness: true"
end

def get_length(options)
	return ", length: {#{options}}"
end

def get_email
	return ", email: true"
end

def validation_list
	return "validations can be: present, number, integer, allow_blank, unique, email, " +
				 "length:<operator><number>\n" +
				 "Notes:  <number> represents the number to be used as a length option.\n"
				 "Length options are:\nmin: minimum\nmax: maximum\neql: equal\n"
end