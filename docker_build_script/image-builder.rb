#!/usr/bin/ruby -w
# Add comments explaining how it works.

puts 'Step 1: Checking SCCcredentials'
if(File.exist?('SCCcredentials'))
   puts 'OK'
else
   puts 'SCCcredentials file not found, please create one with your SCC credentials'
   exit
end

puts 'Step 2: Checking Dockerfile'
if(File.exist?('Dockerfile'))
   puts 'OK'
else
   puts 'Dockerfile not found, exiting...'
   exit
end

# Check number of arguments (should always be two)
if ARGV.length != 2
  puts "We need exactly two arguments"
  exit
end

image = ARGV[0]
tag = ARGV[1]

puts 'Step 3: Checking BUILDKIT syntax requirements'
line1 = "# syntax = docker/dockerfile:experimental"
line1.freeze
syntax = File.open("Dockerfile").first.chomp
if line1 .eql? syntax
  command = "DOCKER_BUILDKIT=1 docker build --no-cache --pull --secret id=SCCcredentials,src=SCCcredentials -t #{image}:#{tag} ."
  exec command
else
  puts 'Not correct Dockerfile syntax, please add "'+line1+'" at the top of the file'
end
