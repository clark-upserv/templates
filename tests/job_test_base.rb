    test 'Should ChangeDescription when ChangeJobName job is called' do
      # DeleteThis - insert assertions pre-job
      ChangeJob.perform_now(ChangeArgs)
      @ChangeObject.reload
      # DeleteThis - insert at least one assertion per line of code in job
    end
