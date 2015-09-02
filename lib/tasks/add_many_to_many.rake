# File-writing best practices found at:
# http://stackoverflow.com/questions/4397412/read-edit-and-write-a-text-file-line-wise-using-ruby

# Making tasks accept commandline-style args found at:
# http://thepolymathlab.com/4-ways-to-pass-arguments-to-a-rake-task
require 'tempfile'
require 'fileutils'
require 'rake'

desc "add many-to-many migration"
task :add_many_to_many do
	ARGV.each { |a| task a.to_sym do ; end }
	ARGV.shift #get rid of task name form args
	# Make sure the args are in the order that Ruby expects.
	ARGV.map! {|arg| arg.downcase.singularize}
	add_mtm_migration(ARGV)
end

def add_mtm_migration(args)
	Dir.chdir(Rails.root)
	if (args.count == 2 and
			File.file?("app/models/#{args[0]}.rb") and
			File.file?("app/models/#{args[1]}.rb"))
		if (args[1] < args[0])
			temp = args[0]
			args[0] = args[1]
			args[1] = temp
		end
		name = "add_#{args[0].pluralize}_#{args[1].pluralize}_association"
		table_symbol = ":#{args[0].pluralize}_#{args[1].pluralize}"
		timestamp = Time.now.strftime("%Y%m%d%H%M%S")
		filename = "#{timestamp}_#{name}.rb"
		path = "db/migrate/#{filename}"

		File.open(path, "w") do |file|
			file.write("class #{name.classify} < ActiveRecord::Migration\n" +
				"\tdef change\n" +
				"\t\tcreate_table #{table_symbol}, :id => false do |t|\n" +
				"\t\t\tt.references :#{args[0]}, null: false\n" +
				"\t\t\tt.references :#{args[1]}, null: false\n" +
				"\t\tend\n" +
				"\t\tadd_index(#{table_symbol}, [:#{args[0]}_id, :#{args[1]}_id])\n" +
				"\tend\n" +
				"end\n"
			)
		end
		#Update table 1's model
		update_associations(args[0], args[1])
		#Update table 2's model
		update_associations(args[1], args[0])
		puts "Run 'rake db:migrate' to update the CMS application."
	else
		puts "Usage: rake add_many_to_many table1 table2"
		puts "Note: table1 and table2 must be the names of models in app/models"
	end
end

def update_associations(model, association)
	filename = "#{model}.rb"
	path = "app/models/#{filename}"
	temp_file = Tempfile.new(filename)
	begin
		File.open(path, "r") do |f|
			f.each_line do |line|
				temp_file.puts line
				if (line.strip.eql?("#ASSOCIATIONS"))
					temp_file.puts "\thas_and_belongs_to_many :#{association.pluralize}"
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