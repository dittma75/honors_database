require 'rails'
require 'rake'
require 'fileutils'
require 'task_helper.rb'
include TaskHelper

desc "add model, table migration, controller, and views"
task :add_table do
	ARGV.each { |a| task a.to_sym do ; end }
	ARGV.shift #get rid of task name form args
	# Make sure the args are in the order that Ruby expects.
	ARGV.map! do |arg|
		new_arg = arg.downcase.singularize.gsub(/\W/, '')
		if (arg.start_with?('{') and arg.end_with?('}') and not (arg.eql?(ARGV[0])))
			arg = '{' + new_arg + '}'
		else
			arg = new_arg
		end
	end
	
	if (ARGV.count >= 2 and /.*\{\w+\}.*/.match(ARGV.join(' ')))
		Dir.chdir(Rails.root)
		model_args = ARGV.dup
		migration_args = ARGV.dup
		write_model_file(model_args)
		write_migration_file(migration_args)
		write_controller_file(ARGV[0])
		write_views(ARGV[0])
		write_resource_entry(ARGV[0])
		puts "Run 'rake db:migrate' to update the CMS application."
	else
		puts "Usage: rake add_table table_name {name_attr}:type normal_attr:type {name_attr2}:type ..."
		puts "Note: At least one name attribute (one surrounded by {}s) must be specified."
	end
end

def write_model_file(args)
	name_attrs = []
	args[0] = args[0].singularize
	for i in 1...args.count
		#Throw the type away
		args[i] = args[i].gsub(/:.*/, "")
		
		if (/\{.+\}/.match(args[i]))
			args[i] = TaskHelper.fix_reserved_words(args[i].gsub(/\{|\}/, ""))
			name_attrs.push("\#\{self.#{args[i]}\}")
		else
			#Fix reserved words on non-name attributes
			args[i] = TaskHelper.fix_reserved_words(args[i])
		end
	end
	
	File.open("app/models/#{args[0]}.rb", 'w') do |file| 
		file.write("class #{args[0].classify} < ActiveRecord::Base\n" +
			"\tattr_protected :id, :created_at, :updated_at\n" +
			"\t"+'#ASSOCIATIONS' + "\n" +
			"\t"+'#VALIDATIONS' + "\n" +
			"\tdef name\n" +
			"\t\t" +'return "' + "#{name_attrs.join(", ")}" + '"' + "\n" +
			"\tend\n" +
			"end"
		)
	end
end

def write_migration_file(args)
	args[0] = args[0].singularize
	for i in 1...args.count
		args[i] = args[i].gsub(/\{|\}/, "")
	end
	types = [nil]
	valid_types = ["integer", "string", "decimal", "boolean"]
	
	for j in 1...args.count
		type = args[j].split("\:")[1]
		args[j] = args[j].gsub(/:.*/, "")
		
		if (valid_types.include?(type))
			types.push(type);
		else
			types.push("string");
		end
	end
	timestamp = Time.now.strftime("%Y%m%d%H%M%S")
	filename = "#{timestamp}_create_#{args[0].pluralize}.rb"
	path = "db/migrate/#{filename}"
	
	columns = ""
	for k in 1...args.count
		columns += "\t\t\tt.#{types[k]} :#{TaskHelper.fix_reserved_words(args[k])}\n"
	end
	File.open(path, 'w') do |file|
		file.write(
			"class Create#{args[0].classify.pluralize} < ActiveRecord::Migration\n" +
			"\tdef change\n" +
			"\t\tcreate_table :#{args[0].pluralize} do |t|\n" +
			"#{columns}\n" +
			"\t\t\tt.timestamps\n" +
			"\t\tend\n" +
			"\tend\n" +
			"end\n"
		)
	end
end

def write_controller_file(name)
	File.open("app/controllers/#{name.pluralize}_controller.rb", 'w') do |file|
		file.write(
			"class #{name.classify.pluralize}Controller < SuperController\n" +
			"\tdef index\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"\tdef show\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"\tdef new\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"\tdef create\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"\tdef edit\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"\tdef update\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"\tdef destroy\n" +
			"\t\tsuper(#{name.classify})\n" +
			"\tend\n" +
			"end"
		)
	end
end

def write_views(name)
	Dir.chdir('app/views')
	unless (File.exist?("#{name.pluralize}"))
		FileUtils.mkdir("#{name.pluralize}", mode: 0755)
	end
	Dir.chdir("#{name.pluralize}")
	['edit', 'index', 'new', 'show'].each do |file|
		write_view(file)
	end
	File.open('_form.html.erb', 'w') do |file|
		file.write('<%= render "shared/form" %>')
	end
	
	# write menu entry
	Dir.chdir(Rails.root)
	Dir.chdir('app/views/shared')
	File.open('_menu.html.erb', 'a') do |file|
		file.write("\n<%= link_to '#{name.titleize.pluralize}', #{name.pluralize}_path %><br/>")
	end
	Dir.chdir(Rails.root)
end

def write_view(filename)
	File.open("#{filename}.html.erb", 'w') do |file|
		file.write("<%= render \"shared/#{filename}\" %>")
	end
end

def write_resource_entry(table_name)
	filename = "routes.rb"
	path = "config/#{filename}"
	temp_file = Tempfile.new(filename)
	begin
		File.open(path, "r") do |f|
			f.each_line do |line|
				temp_file.puts line
				if (line.strip.eql?("#RESOURCES"))
					temp_file.puts "\tresources :#{table_name.pluralize}"
				end
			end
		end
		temp_file.close
		FileUtils.mv(temp_file.path, path)
	ensure
		temp_file.close
		temp_file.unlink
	end	
end