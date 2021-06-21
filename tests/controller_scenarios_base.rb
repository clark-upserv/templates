    # Tests for ChangeAction action
    # DeleteThis - set up params or delete
    def ChangeAction_params
      { ChangeScope: { ChangeAttribute: ChangeValue } }
    end

    test 'Should not ChangeAction when not logged in' do
      ChangeHtmlMethod ChangeUrlHelper_path(id: ChangeId), params: ChangeAction_params, xhr: true
      assert assigns(:access_denied_not_logged_in)
    end

    test 'Should not ChangeAction when logged in as base user' do
      sign_in @base_user
      # DeleteThis - copy / paste request method here
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - this test may not be applicable for index or create (on inedex, test that other accout items are note part of load; on create if account_id is set based on current_user, check that account matches account of current_user)
    # DeleteThis - repeat this test for every user role that has access
    test 'Should not ChangeAction for different account when logged in as ChangeUserWithPermission user' do
      sign_in @user_with
      # DeleteThis - copy / paste request method here
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - insert base controller tests
