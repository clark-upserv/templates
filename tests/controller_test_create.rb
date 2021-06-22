    # DeleteThis - repeat this test for every user role that has access and all valid control flows
    test 'Should create when logged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      assert_difference 'ChangeModel.count', 1 do
        post ChangePath_path, params: create_params, xhr: true
      end
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      assert flash[:success]
      @ChangeObject = ChangeModel.last
      assert_equal @ChangeObject, assigns(:ChangeObject)
      assert_equal @ChangeUserWithPermission.account_id, @ChangeObject.ChangeChainToCoreAccountId
      assert_equal 'ChangeValue', @ChangeObject.ChangeAttribute
      # DeleteThis - insert at least one assertions per line of code in control flow
    end

    # DeleteThis - repeat test for all invalid control flows.
    # DeleteThis - NOTE: this only needs to be tested for one user role (we're testing invalid flows, not authorization)
    # DeleteThis - NOTE: this also only needs to be tested for one invalid - we are testing control flow, not all model validations)
    test 'Should not create when params are invalid' do
      sign_in(@ChangeUserWithPermission)
      invalid_create_params = create_params
      invalid_create_params[:ChangeScope][:ChangeAttribute] = ChangeInvalidValue
      assert_no_difference 'ChangeModel.count' do
        post ChangePath_path, params: invalid_create_params, xhr: true
      end
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      assert flash[:danger]
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
