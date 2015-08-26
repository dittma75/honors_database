require 'rails'

def write_model_file(args)
	name_attrs = []
	for i in 1...args.count
		#Throw the type away
		args[i] = args[i].gsub(/:.*/, "")
		if (/\{.+\}/.match(args[i]))
			name_attrs.push("#" + args[i])
			args[i] = args[i].gsub(/\{|\}/, "")
			puts args[i]
		end
	end
	
	puts "class #{args[0].classify} < ActiveRecord::Base"
	puts "\tattr_protected :id, :created_at, :updated_at"
	puts "\tdef name"
	puts "\t\t" +'return "' + "#{name_attrs.join(", ")}" + '"'
	puts "\tend"
	puts "end"
end

def write_migration_file(args)
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
	puts "class Create#{args[0].classify.pluralize} < ActiveRecord::Migration"
  puts "\tdef change"
  puts "\t\tcreate_table :#{args[0].pluralize} do |t|"
	for i in 1...args.count
		puts "\t\t\tt.#{types[i]} :#{args[i]}"
	end
  #puts "\t\t\tt.#{type} :#{arg}, #{options.join(", ")}"
	puts "\t\t\tt.timestamps"
  puts "\t\tend"
	puts "\tend"
	puts "end"
end

def write_controller_file(name)
	puts "class #{name.classify.pluralize}Controller < SuperController"
	puts "\tdef index"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "\tdef show"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "\tdef new"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "\tdef create"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "\tdef edit"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "\tdef update"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "\tdef destroy"
	puts "\t\tsuper(#{name.classify})"
	puts "\tend"
	puts "end"
end

unless (ARGV.count < 1)
	model_args = ARGV.dup
	migration_args = ARGV.dup
	write_model_file(model_args)
	write_migration_file(migration_args)
	write_controller_file(ARGV[0])
else
	puts "Usage: generate_model table_name {name_attr}:type normal_attr:type {name_attr2}:type ..."
end