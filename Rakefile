require 'erb'

#
# TODO: put this in some reusable file?
#
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end
end

desc "Creates the folder structure and some initial files to bootstrap the process of creating new modules"
task :new_module, [:name] do |t, args|
  name = args.name

  if args.empty?
    fail "Please provide a name for the new module".red
  end

  # check that the module doesn't already exist
  if File.exists? "./#{name}"
    fail "Package #{name} already exists, aborting".red
  end

  puts "Creating module name: #{name}"

  # create the folder structure
  print "Creating folder structure... "
  module_folder = "./"
  folders = [ "#{module_folder}/#{name}", "#{module_folder}/#{name}/manifests", "#{module_folder}/#{name}/templates", "#{module_folder}/#{name}/files" ]
  folders.each do |f|
      FileUtils.mkdir(f)
  end
  puts "Done".green

  # Use all .erb files present in the templates/ folder to initialize basic manifests. If we ever need
  # more default manifests, we can simply drop another .erb file in the folder
  print "Generating default manifests... "

  Dir.glob("templates/*.erb") do |template|
    # build the right name for the manifest
    manifest_name = File.basename(template).gsub(".erb", "")
    print "#{manifest_name} "

    # process the ERB template and write it out to the manifest file
    erb = ERB.new(File.read(template))
    File.open("#{module_folder}/#{name}/manifests/#{manifest_name}", "w+") { |f| f << erb.result(binding) }
  end
  puts "Done".green

  # run the puppet validator to make sure that syntax is valid
  print "Validating syntax... "
  if system("puppet parser validate #{name}/manifests/*.pp") == false
    puts "Error".red
    fail "Puppet's parser did not validate the generated code".red
  end
  
  puts "Done".green

  puts "New module #{name} is avabile in modules/#{name}".green  
end

desc "Initializes all modules"
task :bootstrap do |t|
  print "Initializing top-level git submodules... "

  system "git submodule init && git submodule update"

  puts "Done".green
end

desc "Test the syntax of all modules"
task :test_module, [:name] do |t, args|
  module_name = args[:name]

  if module_name == nil
    fail "Please provide a module name".red
  end

  if !File.directory?(module_name)
    fail "Module #{module_name} does not exist".red
  end

  print "Validating syntax of manifests in module #{module_name}..."
  system "puppet parser validate #{module_name}/manifests/*.pp"
  puts "Done".green
end

desc "Tests all modules"
task :test_all do |t|
  Dir.glob("*") do |d|
    if File.directory?("#{d}/manifests")
      Rake::Task["test_module"].execute({:name => d})
    end 
  end
end
