require 'jenkins'
require 'git'

repository = Git.open( File.dirname(__FILE__))
puts repository.branches.remote

jenkins = Jenkins::Api
puts jenkins.summary