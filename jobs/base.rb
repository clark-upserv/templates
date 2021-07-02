    # DeleteThis - if "future methods" - ie set(wait: 2.seconds) - are used, manually set non-production queue adaptor to async
    # Manually setting to queue adapter in non-production environemnts to async so that `set(wait; 2.seconds) will work
    self.queue_adapter = :async unless Rails.env.production?
    # DeleteThis - default queue adaptor set to inline (in Upserv) for non-production environments 
    # DeleteThis - inline allows background jobs to be run from tasks (see notes as to why). BUT inline does not allow "future methods" - SomeJob.set(wait: 2.seconds).perform_later
    # DeleteThis - async allows future methods, but jobs in tasks will not actually run (see notes as to why)

    def perform(ChangeArguments)
      # DeleteThis - set logic to not run job if record was deleted after job was called but before job was run. Below is an example for a job with one main object, but build logic to according to job needs
      return unless (ChangeObject = ChangeModel.find_by_ChangeAttribute(ChangeValue))

      # DeleteThis - insert code. Remember to split jobs and manage potential errors well (especially if job contains loop)
    end
