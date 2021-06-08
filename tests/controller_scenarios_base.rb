    # Tests for ChangeAction action
    # DeleteThis - set up params or delete
    def ChangeAction_params
      { ChangeScope: { ChangeAttribute: ChangeValue } }
    end

    test 'Should not ChangePermission when not logged in' do
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_not_logged_in)
    end

    test 'Should not ChangePermission when logged in as base user' do
      sign_in @base_user
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - insert base controller tests for user that has access to feature

    test 'Should not ChangePermission for different account when logged in as UserWithAccess user' do
      sign_in @base_user
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_while_logged_in)
    end
