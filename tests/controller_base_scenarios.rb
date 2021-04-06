  test 'Non-logged in user cannot ChangePermission' do
    ChangeMethodUrlAndParams
    assert assigns(:access_denied_not_logged_in)
  end

  test 'Logged in base user cannot ChangePermission' do
    sign_in @base_user
    ChangeMethodUrlAndParams
    assert assigns(:access_denied_while_logged_in)
  end

  test 'Logged in user with ChangePermission Should ChangeThisPls when ChangeThisPls' do
    sign_in(@ChangePermission_user)
    ChangeMethodUrlAndParams
    assert_response :success
    assert_template 'ChangeTemplate'
    ChangeAssertions
  end
