# File-writing best practices found at:
# http://stackoverflow.com/questions/4397412/read-edit-and-write-a-text-file-line-wise-using-ruby

# Making tasks accept commandline-style args found at:
# http://thepolymathlab.com/4-ways-to-pass-arguments-to-a-rake-task
require 'tempfile'
require 'fileutils'
require 'rake'

desc "add one-to-many migration"
task :add_one_to_many do
	ARGV.each { |a| task a.to_sym do ; end }
	ARGV.shift #get rid of task name form args
	# Make sure the args are in the order that Ruby expects.
	ARGV.map! {|arg| arg.downcase.singularize}
	add_otm_migration(ARGV)
end

def add_otm_migration(args)
	Dir.chdir(Rails.root)
	if (args.count == 2 and
			File.file?("app/models/#{args[0]}.rb") and
			File.file?("app/models/#{args[1]}.rb"))
		name = "add_#{args[0]}_has_#{args[1].pluralize}_association"
		timestamp = Time.now.strftime("%Y%m%d%H%M%S")
		filename = "#{timestamp}_#{name}.rb"
		path = "db/migrate/#{filename}"
		
		File.open(path, "w") do |file|
			file.write("class #{name.classify} < ActiveRecord::Migration\n" +
				"\tdef change\n" +
				"\t\tadd_column :#{args[1].pluralize}, :#{args[0]}_id, :integer\n" +
				"\t\tadd_index(:#{args[1].pluralize}, :#{args[0]}_id)\n" +
				"\tend\n" +
				"end\n"
			)
		end

		add_has_association(args[0], args[1])
		add_belongs_association(args[1], args[0])
	else
		puts "Usage: rake add_one_to_many has_model belongs_model"
		puts "Note: has_model and belongs_model must be the names of models in app/models"
	end
end

def add_has_association(model, association)
	filename = "#{model}.rb"
	path = "app/models/#{filename}"
	temp_file = Tempfile.new(filename)
	begin
		File.open(path, "r") do |f|
			f.each_line do |line|
				temp_file.puts line
				if (line.strip.eql?("#ASSOCIATIONS"))
					temp_file.puts "\thas_many :#{association.pluralize}"
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

def add_belongs_association(model, association)
	filename = "#{model}.rb"
	path = "app/models/#{filename}"
	temp_file = Tempfile.new(filename)
	begin
		File.open(path, "r") do |f|
			f.each_line do |line|
				temp_file.puts line
				if (line.strip.eql?("#ASSOCIATIONS"))
					temp_file.puts "\tbelongs_to :#{association}"
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