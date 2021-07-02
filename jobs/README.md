Creating Job
1. Review best practices and notes

2. Create Job - name should be a verb (also note, it will be called with `.perform_later`)
  - default queue: `$ rails generate job namespace/some_verb`
  - specific queue: `$ rails generate job snamespace/some_verb --queue urgent` 
  - example: `$ rails generate job core/deactivate_users` will be called with `Core:DeactivateUsersJob.perform_later(*args)`

3. Edit file 
  - clean per rubo-cop standards
  - delete perform method and replace with base job (,rjba)
  - you can add `retry_on` of `discard_on` methods if necessary. See [here](https://edgeguides.rubyonrails.org/active_job_basics.html#retrying-or-discarding-failed-jobs)

4. Call Job
  - basic: `Namespace::SomeVerb.perform_later(*args)`
  - call with delay:
    - `Namespace::SomeVerb.set(wait: 1.week).perform_later(*args)`
    - `Namespace::SomeVerb.set(wait_until: Date.tomorrow.noon).perform_later(*args)`

5. Create Tests
  - replace auto-generated test file with test job base
  - create test(s)
  - see here for additional assertions for jobs [here](https://edgeapi.rubyonrails.org/classes/ActiveJob/TestHelper.html)

6. Update QA Checklist

Best Practices & Notes:
1. Simple Paramters - do not send objects; send ids or something simple
  - good: `SomeJob.perform_later(user.id)`
  - bad: `SomeJob.perform_later(user)`
  - Note: this is true for `deliver_later` with emails as well

2. Idempotency & Separating jobs
  - If any part of a job fails, then entire job will be repeated
  - So, do not combine multiple jobs that can be split up
  - If some job A and job B are combined into a single job, and job A is successful but job B fails, then job A will be repeated multiple times as job be is repeated

3. Concurrency - if job depends on some other action taking place, make sure it is done within job because you have no control on when processes are done for other jobs or any task done outside of the job

4. Resource Deletion between calling jub and running job
  - make sure to add protective logic in case object is deleted after job is called but before job is run
  - there is a note for this in base job

5. Loops - unless loop is very simple, create 2 jobs
  - job 1: runs loop with very simple call to job 2
  - job 2: runs complicated code that could fail
  - this way: if first job will run without problem and if any of the sub jobs fail, only that job will be retried (as opposed to all previous iterations of the loop)
  - an alternate solution is to have one job with exception handling and retries set to 0 (con - if an iteration fails, it will not be retried)

6. Cancancan, `accessible_by` and `current_ability`
  - `current_abilit = Ability.new(user)`
  - `Core::User.accessible_by(current_ability, index)...`
  - `current_ability.can?(...)`
