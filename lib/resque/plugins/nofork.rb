require "resque/worker"
require "get_process_mem"

module Resque::Plugins
  module Nofork
    VERSION = "0.0.2"

    def work_with_nofork(*args)
      @cant_fork = true
      work_without_nofork(*args)
    end

    def nofork_max_jobs
      processed >= [ENV["JOBS_PER_WORKER"].to_i, 1].max
    end

    def nofork_max_memory
      return if ENV["MEM_PER_WORKER"].nil?
      GetProcessMem.new.mb >= ENV["MEM_PER_WORKER"].to_i
    end

    def shutdown_with_nofork
      shutdown_without_nofork || nofork_max_jobs || nofork_max_memory
    end

    def self.included(base)
      base.instance_eval do
        alias_method :work_without_nofork, :work
        alias_method :work, :work_with_nofork

        alias_method :shutdown_without_nofork, :shutdown?
        alias_method :shutdown?, :shutdown_with_nofork
      end
    end
  end

  Resque::Worker.send(:include, Nofork)
end
