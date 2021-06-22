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

    # DeleteThis - use for show, edit, update, destroy; repeat this test for every user role that has access
    # DeleteThis - do not use for index (other account will be tested in index tests)
    # DeleteThis - do not use for create (test that current_user account is set automatically in action)
    # DeleteThis - use for new if necessary
    test 'Should not ChangeAction for different account when logged in as ChangeUserWithPermission' do
      sign_in @ChangeUserWithPermission
      # DeleteThis - copy / paste request method here and change id to @dif_account_ChangeObject.id
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - insert controller test for every user role that has access and all control flows
