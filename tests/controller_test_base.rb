    # DeleteThis - repeat this test for every user role that has access and all control flows
    test 'Should ChangeAction when loged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      ChangeHtmlMethod ChangeUrlHelper_path(id: @ChangeObject.id), params: ChangeAction_params, xhr: true
      # DeleteThisPls use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
