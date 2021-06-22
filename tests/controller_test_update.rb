    # DeleteThis - repeat this test for every user role that has access and all valid control flows
    test 'Should update when logged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      patch ChangePath_path(id: @ChangeObject.id), params: update_params, xhr: true
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      assert flash[:success]
      @ChangeObject.reload
      assert_equal @ChangeObject, assigns(:ChangeObject)
      assert_equal 'ChangeValue', @ChangeObject.ChangeAttribute
      # DeleteThis - insert at least one assertions per line of code in control flow
    end

    # DeleteThis - repeat test for all invalid control flows.
    # DeleteThis - NOTE: this only needs to be tested for one user role (we're testing invalid flows, not authorization)
    # DeleteThis - NOTE: this also only needs to be tested for one invalid - we are testing control flow, not all model validations)
    test 'Should not update when params are invalid' do
      sign_in(@ChangeUserWithPermission)
      invalid_update_params = update_params
      invalid_update_params[:ChangeScope][:ChangeAttribute] = ChangeInvalidValue
      patch ChangePath_path(id: @ChangeObject.id), params: invalid_update_params, xhr: true
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      assert flash[:danger]
      @ChangeObject.reload
      assert_equal 'ChangeValue', @ChangeObject.ChangeAttribute
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
