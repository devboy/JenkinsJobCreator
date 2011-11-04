require 'git'

JOB = "JenkinsBranchTest"

def jenkins_dir
  ENV["HOME"]
end

def repository
  @_repository ||= Git.open( File.dirname(__FILE__) )
end

def jenkins_jobs
  jobs_dir = "#{jenkins_dir}/jobs/"
  Dir.glob( jobs_dir + "*" ).
      keep_if{ |j| File.directory? j }.
      map { |j| j.gsub jobs_dir, "" }
end

def remote_branches
  repository.branches.remote.map(&:to_s).
      keep_if{ |b| b.match(/^remotes\//) && !b.match(/origin\/HEAD/) }.
      map{ |b| b.gsub("remotes/","") }
end

def job_name branch
  JOB+"(#{branch.gsub("origin/","").gsub(/[^a-zA-Z0-9_-]/, "-")})"
end

def candidates
  remote_branches.map{ |b| {:job => job_name(b),:branch => b} }
end

def new_jobs
  candidates.delete_if{ |c|
    puts c[:job], "in jobs?", jenkins_jobs.include?(c[:job])
    jenkins_jobs.include? c[:job] }
end

puts "jenkins jobs:", jenkins_jobs
puts "remote branches:", remote_branches
puts "candidates:", candidates
puts "new jobs:", new_jobs

