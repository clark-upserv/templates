    # Tests for ChangeAction action
    # DeleteThis - set up params or delete
    def ChangeAction_params
      { ChangeScope: { ChangeAttribute: 'ChangeValue' } }
    end

    test 'Should not ChangeAction when not logged in' do
      ChangeHtmlMethod ChangeUrlHelper_path(id: @ChangeObject.id), params: ChangeAction_params, xhr: true
      assert assigns(:access_denied_not_logged_in)
    end

    test 'Should not ChangeAction when logged in as base user' do
      sign_in @base_user
      # DeleteThis - copy / paste request method here
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - if this test is applicable, repeat it for every user role that has access AND for each variation that could end in object for different account
    # DeleteThis - use for show, edit, update, destroy
    # DeleteThis - use for create IF create params could lead to creating object for wrong account. OTHERWISE test in create test that current_user account is set automatically in controller action
    # DeleteThis - do not use for index (other account will be tested in index tests)
    # DeleteThis - use for new if necessary
    test 'Should not ChangeAction for different account when logged in as ChangeUserWithPermission' do
      sign_in @ChangeUserWithPermission
      # DeleteThis - change params (using below) OR change id in reguest method below
      invalid_ChangeAction_params = ChangeAction_params
      invalid_ChangeAction_params[:ChangeScope][:ChangeAttribute] = ChangeInvalidValue
      # DeleteThis - copy / paste request method here and make sure to update params to invalid or change id to @dif_account_ChangeObject.id
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - insert controller test for every user role that has access and all control flows
