require 'git'

def jenkins_dir
  ENV["HOME"]
end

def jenkins_jobs
  jobs_dir = "#{jenkins_dir}/jobs/"
  Dir.glob( jobs_dir + "*" ).
      keep_if{ |j| File.directory? j }.
      map { |j| j.delete jobs_dir }
end

repository = Git.open( File.dirname(__FILE__))

puts jenkins_jobs
