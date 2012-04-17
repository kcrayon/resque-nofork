# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "resque-nofork"
  s.version     = "0.0.1"
  s.authors     = ["kcrayon"]
  s.email       = ["kcrayon@users.noreply.github.com"]
  s.homepage    = ""
  s.summary     = %q{A Resque plugin that prevents the worker from forking.}
  s.description = %q{Instead of forking and doing a job in a child process, do the job in the worker process and exit after a fixed number of jobs.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "resque"
end
