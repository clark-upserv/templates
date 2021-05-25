
    def perform(ChangeArguments)
      # DeleteThis - set logic to not run job if record was deleted after job was called but before job was run. Below is an example for a job with one main object, but build logic to according to job needs
      return unless (ChangeObject = ChangeModel.find_by_ChangeAttribute(ChangeValue))

      # DeleteThis - insert code. Remember to split jobs and manage potential errors well (especially if job contains loop)
    end
