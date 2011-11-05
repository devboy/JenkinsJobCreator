class JenkinsJobManager

  def initialize job, jenkins_dir, git_dir
    @job = job
    @jenkins_dir = jenkins_dir
    @git_dir = git_dir
  end

  def repository
    @_repository ||= Git.open(@git_dir)
  end

  def jenkins_jobs
    jobs_dir = "#{@jenkins_dir}/jobs/"
    Dir.glob(jobs_dir + "*").
        keep_if { |j| File.directory? j }.
        map { |j| j.gsub jobs_dir, "" }
  end

  def remote_branches
    repository.branches.remote.map(&:to_s).
        keep_if { |b| b.match(/^remotes\//) && !b.match(/origin\/HEAD/) }.
        map { |b| b.gsub("remotes/", "") }
  end

  def job_name branch
    @job+"(#{branch.gsub("origin/", "").gsub(/[^a-zA-Z0-9_-]/, "-")})"
  end

  def job_dir job
    "#{@jenkins_dir}/jobs/#{job}"
  end

  def candidates
    remote_branches.map { |b| {:job => job_name(b), :branch => b} }
  end

  def new_job_candidates
    candidates.delete_if { |c| jenkins_jobs.include? c[:job] }
  end

  def delete_job_candidates
    job_candidates = candidates +  [{:job => @job, :branch => "**"},{:job => job_name("jenkins-conf"), :branch => "jenkins-conf"}]
    jenkins_jobs.keep_if{ |j| j.match(/^#{@job}/) }.
        keep_if{ |j| job_candidates.detect{ |c| c[:job] == j }.nil? }
  end

  class JobAction < Thor
    include Thor::Actions

    def self.source_paths
      File.dirname __FILE__
    end

    def create_job_from_template job, job_dir, branch
      @branch, @job = branch, job
      directory "job_template", job_dir
    end

    no_tasks {

      def branch
        @branch
      end

      def job
        @job
      end
    }

  end
end