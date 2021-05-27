# DeleteThis - First, choose to either do one task or run a task that calls multiple tasks (see and delete below)
# DeleteThis - Then, set app which is name of upserv "app" (ie core, training, hr, etc.)
# DeleteThis - Then, set task type: :cron or :migration_helper
# DeleteThis - Then, set category which is a name for the group of tasks specific to this file
# DeleteThis - Lastly, set task name which should be a verb (ex. "send_update_emails" NOT "update_email_sender")
# Development: $ bundle exec rake ChangeApp_ChangeTaskType_ChangeCategory_ChangeTaskName
# Heroku CLI: $ bundle exec heroku run rake ChangeApp_ChangeTaskType_ChangeCategory_ChangeTaskName
# Heroku Scheduler: $ rake ChangeApp_ChangeTaskType_ChangeCategory_ChangeTaskName
desc 'ChangeDescription'
task ChangeApp_ChangeTaskType_ChangeCategory_ChangeTaskName: %i[ChangeTask1 ChangeTask2 ChangeTask3]
task ChangeApp_ChangeTaskType_ChangeCategory_ChangeTaskName: :environment do
  # DeleteThis - do not combine sub-tasks into one single task if they can be split up. If 2 sub-tasks that could be separate are bundled into a single task, and the first subtask fails (ex. "send email to admin"), then the second task will not be run (ex. "send email to user")
  # DeleteThis - For cron jobs, be very cognizant of the task size. If it's a large, expensive task, then push task to background job and simply use cron job to call background job
  # DeleteThis - NOTE:  the :environment" dependency allows items from your environment (such as models, reocords, other?, etc.). A dependency in rake tasks is simply just another rake task that will be called before the defined task is run. So this would cause the :environment task to be run before the task you are defining.
  # DeleteThis - insert code, repeat block or date helper if migration helper task
  # DeleteThis - include message after success if necessary
  puts 'ChangeMessage'
end
