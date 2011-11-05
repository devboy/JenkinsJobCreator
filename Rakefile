require 'git'
require 'thor'
require File.dirname(__FILE__) + '/jenkins_job_manager'

job_manager = JenkinsJobManager.new "JenkinsBranchTest", ENV["HOME"], File.dirname(__FILE__)

puts "jenkins jobs:", job_manager.jenkins_jobs
puts "remote branches:", job_manager.remote_branches
puts "candidates:", job_manager.candidates
puts "new jobs:", job_manager.new_job_candidates
puts "delete jobs:", job_manager.delete_job_candidates

task :default