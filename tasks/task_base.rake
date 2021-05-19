      insert run notes
      desc 'ChangeDescription'
      # DeleteThis - use one of the below: Either create create a task calling multiple tasks or create a single task
      task ChangeTaskName: %i[ChangeTask1 ChangeTask2 ChangeTask3]
      task ChangeTaskName: :environment do
        insert task notes
        # DeleteThis - insert code, repeat block or date helper if migration helper task
      end
