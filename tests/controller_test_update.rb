    # DeleteThis - repeat this test for every user role that has access
    test 'Should update when logged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      patch ChangePath_path(id: @ChangeObject.id), params: update_params, xhr: true
      @ChangeObject.reload
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      # DeleteThis - insert at least one assertions per line of code in controller
      assert flash[:success]
      assert_equal 'ChangeValue', @ChangeObject.ChangeAttribute
    end

    # DeleteThis - invalid control flow only needs to be tested for one user role (we're testing invalid flow, not authorization)
    test 'Should not update when params are invalid' do
      sign_in(@ChangeUserWithPermission)
      invalid_update_params = update_params
      invalid_update_params[:ChangeScope][:ChangeAttribute] = ChangeInvalidValue
      patch ChangePath_path(id: @ChangeObject.id), params: invalid_update_params, xhr: true
      @ChangeObject.reload
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      # DeleteThis - insert at least one assertions per line of code in controller
      assert flash[:danger]
      assert_equal 'ChangeValue', @ChangeObject.ChangeAttribute
    end
