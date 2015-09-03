require 'rails'
require 'rake'
require 'fileutils'
require 'task_helper.rb'
include TaskHelper

desc "remove model, table migration, controller, and views"
task :delete_table do
	ARGV.each { |a| task a.to_sym do ; end }
	ARGV.shift #get rid of task name form args
	# Make sure the args are in the order that Ruby expects.
	ARGV.map! { |arg| arg.downcase.singularize.gsub(/\W/, '') }
	
	if (ARGV.count == 1)
		Dir.chdir(Rails.root)
		delete_model_file(ARGV[0])
		write_revert_migration_file(ARGV[0])
		delete_controller_file(ARGV[0])
		remove_views(ARGV[0])
		delete_resource_entry(ARGV[0])
		puts "Run 'rake db:migrate' to update the CMS application."
	else
		puts "Usage: rake delete_table table_name"
	end
end

def delete_model_file(table_name)
	Dir.chdir(Rails.root.join('app', 'models'))
	FileUtils.remove_file("#{table_name}.rb")
	Dir.glob('*.rb').each do |filename|
		temp_file = Tempfile.new(filename)
		begin
			File.open(filename, "r") do |f|
				f.each_line do |line|
					# Remove
					unless (line.strip.split(' ').include?(":#{table_name.pluralize}"))
						temp_file.puts line
					end
				end
			end
			temp_file.close
			FileUtils.mv(temp_file.path, filename)
		ensure
			temp_file.close
			temp_file.unlink
		end	
	end
	Dir.chdir(Rails.root)
end

def write_revert_migration_file(args)
	timestamp = Time.now.strftime("%Y%m%d%H%M%S")
	filename = "#{timestamp}_create_#{args[0].pluralize}.rb"
	path = "db/migrate/#{filename}"

	File.open(path, 'w') do |file|
		file.write(
			"class Delete#{args[0].classify.pluralize} < ActiveRecord::Migration\n" +
			"\tdef up\n" +
			"\t\tdrop_table :#{args[0].pluralize}" +
			"\tend\n" +
			"\tdef down\n" +
			"\t\traise ActiveRecord::IrreversibleMigration\n" +
			"\tend\n" +
			"end\n"
		)
	end
end

def delete_controller_file(name)
	Dir.chdir(Rails.root.join('app', 'controllers'))
	FileUtils.rm("#{name.pluralize}_controller.rb")
	Dir.chdir(Rails.root)
end

def delete_views(name)
	Dir.chdir(Rails.root.join('app', 'views'))
	# Make sure directory exists before deleting
	if (File.exist?("#{name.pluralize}"))
		FileUtils.rm_rf("#{name.pluralize}")
	end
	Dir.chdir(Rails.root)
end

def delete_resource_entry(table_name)
	Dir.chdir(Rails.root)
	filename = "routes.rb"
	path = "config/#{filename}"
	temp_file = Tempfile.new(filename)
	begin
		File.open(path, "r") do |f|
			f.each_line do |line|
				unless (line.strip.split(' ').include?(":#{table_name.pluralize}"))
					temp_file.puts line
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
