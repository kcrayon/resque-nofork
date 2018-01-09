resque-nofork
====

Just like resque-jobs-per-fork, but without forking at all. Perform the job in the worker, and exit after a fixed number of jobs.

Designed to work with [resque-pool](https://github.com/nevans/resque-pool) which will maintain the worker count from a master process.
