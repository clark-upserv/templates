# NOTE: create rake tasks in the lib/tasks folder with a .rake extension. Create with app namespace name first, then task type namespace second (ex. migration_helper, cron, etc.). NOTE: some early tasks did this in reverse and need to be refactored...

# leave this note on all migration_helper files
# NOTE: Delete tasks after they have been run so that no one can call them again (migration helpers should be one time tasks)

# Fpp App Namespace
namespace :fpp do
  # [task type - cron, migration_helpoer, etc.] Type Namespace
  namespace :some_task_type do
    
    # to run in development : $ bundle exec rake fpp:som_task_type:do_something
    # to run on heroku CLI try: $ heroku run rake fpp:some_task_type:do_something
    # if that doesn't work on heroku CLI , try: $ bundle exec heroku run rake fpp:some_task_type:do_something
    # when adding task to heroku scheduler, use this: rake fpp:some_task_type:do_something
    desc "give some description"
    task do_something: :environment do
    # NOTE: name should be a verb (ex. "send_update_emails" NOT "update_email_sender")
    # NOTE: add the "=> :environment" dependency if you need anything from your environment (such as models, reocords, other?, etc.). A dependency in rake tasks is simply just another rake task that will be called before the defined task is run. So this would cause the :environment task to be run before the task you are defining.
    # NOTE: For all rake tasks, but especially cron jobs, do not combine sub-tasks into one single task if they can be split up. If 2 sub-tasks that could be separate are bundled into a single task, and the first subtask fails (ex. "send email to admin"), then the second task will not be run (ex. "send email to user") 
    # NOTE: For cron jobs, be very cognizant of the task size. If it's a large, expensive task, then push task to background job and simply use cron job to call background job 
    
      # [if extra date logic is needed for non-basic heroku scheduler frequencies. Heroku scheduler allows for every 10 minutes, every hour or every day. So if those options don't work, then you need to add additional logic here. The above logic will only run on Mondays (wday 1 = Monday). So Heroku Scheduler will run the task every single day, but it the code will not be executed unless the day in Monday]
      # only run on a specific weekday (Monday = 1)
      if Date.today.wday == 1 
        # some ruby code
      end 
      # run on multiple specific weekdays (Monday = 1)
      if [1,2,3,4,5,6,7].include?(Date.today.wday)
        # some ruby code
      end 
      
      # [if no extra date logic is needed]
      # some ruby code

      # repeat block with exception handling - NOTE: This is only needed if code in block is more than just one like (ex. you don't need exception handling if repeat block is just one line of code calling "Fpp::SomeMailer.some_email.deliver_later" because if that breaks for any iteration, it should break for all iterations)
      # NOTE: For cron jobs (and possibly others if necessary), you may need exception handling so that if one sub-task errors, the other sub-tasks will still go on
      10.times do 
        # start exception control flow
        begin
          # have code that could possibly error
          raise 
        # add logic for errors
        rescue
          # some exception handling
        # extra logic on success if necessary
        else
          # some logic
        # extra logic no matter what if necessary
        ensure
          # some logic
        end      
      end
      
    end

    # NOTE: you can call multiple tasks from a new task without using a block or any code. It automatically adds the namespace if wihtin the namespace. I'm not sure how to, or if you can, call tasks 
    # run with: $ bundle exec rake fpp:som_task_type:run_multi_tasks
    desc "run multiple tasks"
    task run_multiple_tasks: [:task_1, :task_2, :task_3]
    # NOTE: name should be a verb (ex. "run_email_tasks" NOT "email_tasks")

    # NOTE: you can also create custom methods to use inside the rake task blocks
    def some_method
      # some ruby code
    end

  end
end


