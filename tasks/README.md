Definitions & Intro
- all tasks go in lib/tasks with .rake extension
- Rake tasks are tasks that can be run from the shell 
- Cron Jobs are a specific type of rake task used with a scheduler (currently using Heroku Scheduler) which perform the task at a specific interval (ex. Every "Monday morning," etc.)
- Migration Helpers are a specific type of rake task used to help manage migrations (ex. You add a column to Core::User called is_type and is_type cannot be nil… well you need to update all the current Core::User instances because they won't have any value for this)
- NOTE: background jobs may seem to overlap with rake tasks (cron jobs, migration helpers, others), but really are categorically different.
  - They are similar in that they both execute small bits of ruby code with a particular purpose.
  - They are different in that background jobs are called from ruby code while rake tasks are called from the shell.
  - Rake tasks may call background jobs - so you could schedule a cron job that in turns calls a background job.
  - Rake tasks are run from web servers while background tasks are run from worker servers (see proc file for web vs. worker).
  - Worker servers are also "redis" servers (the procfile says "worker" but the server type on Heroku, Aws, etc. is "redis")
  
  
1. Create file
  - examples: 
    - base: `lib/tasks/namespace_type_category.rake`
    - for cron task: `lib/tasks/hr_cron_docs.rake` (all the cron jobs related to docs)
    - for migration heloper task: `lib/tasks/training_migration_helper_update_due_dates.rake` (update due date attribute for previously created docs)
  - components:
    - namespace: this is the namespace the task belongs to (ex. "hr" or "training")
    - type: this is the type of task ("cron" or "migration_helper")
    - category: this is a sub-group under the task type (ex. if hr has a lot of cron tasks, then split into groups based on category)
2. Create Task(s) - use mappings 
  - base: ,rtba
  - task: ,rttb
3. Create additional items needed for completion of task
  - instance methods, task methods, mailers, background jobs, etc.
4. QA
  - Create QA List
  - Create seeds (Cron only)
  - QA locally
5. Create tests / run (Cron only)
6. Deploy  
  - job types
    - cron jobs (with Heroku Scheduler)
      - open the scheduler add on
      - add a task
      - inser the rake command - ex. `Bundle exec rake hr:scheduler:send_email`
    - migration helpers - run from console
  - steps
    - Review app - test / QA
    - Staging - test / QA
    - Production - test / QA


    
