    test 'should ChangeThisPls when ChangeThisPls' do
      sign_in(@ChangeUserWithPermission)
      ChangeMethodUrlAndParams
      # DeleteThisPls use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      # DeleteThisPls - insert additional assertions as necessary (in order that code appears in controller) 
    end
