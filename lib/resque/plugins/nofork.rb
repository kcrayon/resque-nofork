require 'resque/worker'

module Resque::Plugins
  module Nofork
    VERSION = "0.0.1"

    def work_with_nofork(*args)
      @cant_fork = true
      work_without_nofork(*args)
    end

    def shutdown_with_nofork
      shutdown_without_nofork || processed >= [ENV['JOBS_PER_WORKER'].to_i,1].max
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
