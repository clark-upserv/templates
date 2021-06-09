    # Tests for ChangeAction action
    # DeleteThis - set up params or delete
    def ChangeAction_params
      { ChangeScope: { ChangeAttribute: ChangeValue } }
    end

    test 'Should not ChangeAction when not logged in' do
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_not_logged_in)
    end

    test 'Should not ChangeAction when logged in as base user' do
      sign_in @base_user
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - repeat this test for every user role that has access
    test 'Should not ChangeAction for different account when logged in as ChangeUserWithPermission user' do
      sign_in @user_with
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_while_logged_in)
    end

    # DeleteThis - insert base controller tests
