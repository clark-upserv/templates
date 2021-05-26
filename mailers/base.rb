      @to_user = Core::User.find_by_id(ChangeId)
      @ChangeObject = ChangeModel.find_by_id(ChangeId)
      @ChangeVariable = options.fetch(ChangeOption, nil)
      @ChangeVariable = ChangeVariable
      # DeleteThis - set logic to not run mailer if record was deleted after mailer was called but before mailer was run.
      return unless ChangeGuardLogic

      # DeleteThis - insert code. Remember to manage potential errors well since this is also a background job
      # DeleteThis - set to_email
      to_email = ChangeToEmail
      # DeleteThis - set from_email or leave blank for default (info@no-reply.upserv.io or see application mailer)
      from_email = "#{@to_user.account.name.downcase.gsub(' ', '-')}@no-reply.upserv.io"
      from_email = ChangeFromEmail
      subject =  ChangeSubject
      mail to: to_email, from: from_email, subject: subject
