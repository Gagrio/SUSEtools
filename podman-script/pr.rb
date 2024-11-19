#!/usr/bin/env ruby
require 'optparse'
require 'yaml'

# Define the path to the configuration file
CONFIG_FILE = File.expand_path('~/Documents/scripts/pr.yaml')

# OptionParser to handle command-line options and arguments
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: pr.rb [options]"

  opts.on("-l", "--local_path PATH", "Local directory path") do |v|
    options[:local_path] = v
  end

  opts.on("-v", "--container_volume PATH", "Container volume path") do |v|
    options[:container_volume] = v
  end

  opts.on("-y", "--yaml_file PATH", "Path to the YAML definition file") do |v|
    options[:yaml_file] = v
  end

  opts.on("-r", "--registry IMAGE", "Registry image (optional)") do |v|
    options[:registry_image] = v
  end

  opts.on("-h", "--help", "Show this help message") do
    # Print the usage directly here and exit
    puts <<-USAGE
Usage: pr.rb [options]

Options:
  -l, --local_path PATH           Local directory path
  -v, --container_volume PATH     Container volume path
  -y, --yaml_file PATH            Path to the YAML definition file
  -r, --registry IMAGE            Registry image (optional)
  -h, --help                      Show this help message

The default values are loaded from the YAML file located at:
#{CONFIG_FILE}
    USAGE
    exit 0 # Exit after printing help
  end
end.parse!

# Load the configuration file
config = YAML.load_file(CONFIG_FILE)

# Set default values from the config file if not provided via options
local_path = options[:local_path] || config['local_path'] || ''
container_volume = options[:container_volume] || config['container_volume'] || ''
yaml_file = options[:yaml_file] || config['yaml_file'] || ''
registry_image = options[:registry_image] || config['registry_image'] || ''

# Validate the input paths
if local_path.empty?
  puts "Error: Local path is required."
  exit 1
end

# if container_volume.empty?
#   puts "Error: Container volume is required."
#   exit 1
# end

if yaml_file.empty?
  puts "Error: YAML file is required."
  exit 1
end

if registry_image.empty?
  puts "Error: Registry image is required."
  exit 1
end

# Print out the configuration for debugging
puts "Loaded configuration from #{CONFIG_FILE}:"
puts YAML.dump(config)

# Construct the podman command
command = "podman run --rm -it --privileged -v #{local_path}:/eib #{registry_image} build --definition-file #{yaml_file}" # container image hardcoded for eib

# Print the command for debugging
puts "Executing this command:"
puts command

# Ask for confirmation to run the command
print "Execute this command? (yes/no): "
confirmation = gets.chomp.downcase
# If input is empty, treat it as 'yes'
confirmation = 'yes' if confirmation.empty?

if confirmation == 'yes'
  # Run the podman command
  system(command)  # This will actually execute the command
else
  puts "Command execution aborted."
end