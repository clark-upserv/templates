  def some_email(to_user_id, from_user_id, other_variable)
    #--- Set Instance Variables ---#
    # set to user by id 
    @to_user = Core::User.find(to_user_id)
    # NOTE: we pass to_user_id & use find instead of passing through to_user because with deliver nonw, you need to use simple arguments (See background jobs - creating jobs notes)
    # set from user by id 
    @from_user = Core::User.find(from_user_id)
    # other variable
    @other_variable = other_variable
   
    #--- Prep Mail Method ---#
    # set to email 
    to_email = @to_user.email
    # set from email 
    from_email = "#{@to_user.account.name.downcase.gsub(' ', '-')}@no-reply.upserv.io"
    # NOTE; use above as standard no-reply from a specific account
    from_email = @from_user.email
    # NOTE: use above if there is a specific from_user
    # NOTE: you can also leave blank and use the global default (which is added automatically if "from: " option is not set in mail method): "info@no-reply.upserv.io" - See application mailer for exact default from
    # set subject 
    subject =  "String with interpolated #{data} as needed"
    # set mail options
    mail to: to_email, from: from_email, subject: subject
  end
