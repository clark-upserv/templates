    # DeleteThis - repeat this test for every user role that has access
    test 'Should ChangeThisPls when loged in as ChangeThisPls' do
      sign_in(@ChangeUserWithPermission)
      ChangeMethodUrlAndParams
      # DeleteThisPls use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      # DeleteThisPls - insert at least one assertions per line of code in controller
    end
