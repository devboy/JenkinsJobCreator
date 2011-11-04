require 'git'

def jenkins_dir
  ENV["HOME"]
end

def jenkins_jobs
  Dir.glob( File.join(jenkins_dir,"jobs")).collect{|j| File.directory? j }
end

repository = Git.open( File.dirname(__FILE__))

puts jenkins_jobs
