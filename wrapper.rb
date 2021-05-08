#!/usr/bin/ruby -w

# Add comments explaining how it works.

# Add check for first argument,use that for image name, else ask for image name
puts 'Please give the image name'
read $image

# Add check for second argument, use that for tag name, else ask for tag name
puts 'Please give the tag name'
read $tag

puts 'Step 1: Checking SCCcredentials'
if(File.exist?('SCCcredentials'))
   puts 'file SCCcredentials exists'
else
   puts 'SCCcredentials file not found, please create one with your SCC credentials'
end

puts 'Step 2: Checking Dockerfile'
if(File.exist?('Dockerfile'))
   puts 'Dockerfile exists'
else
   puts 'Dockerfile not found, exiting...'
   exit
end

puts 'Step 3: Checking BUILDKIT syntax requirements'
line1 = "# syntax = docker/dockerfile:experimental"
line1.freeze
syntax = File.open(Dockerfile).1
if line1 == syntax
# FIX image, tag and command
   BUILDKIT=1 docker image create --pull --id=SCCcredentials $image:$tag .
else
  puts 'Not correct Dockerfile syntax, please add'+line1+'at the top of the file'
