    test 'non-logged in user should not ChangePermission' do
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_not_logged_in)
    end

    test 'logged in base user should not ChangePermission' do
      sign_in @base_user
      ChangeMethodUrlAndParams
      assert assigns(:access_denied_while_logged_in)
    end

    #ReplaceThisPls - insert base controller tests
