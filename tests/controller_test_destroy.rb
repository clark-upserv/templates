    # DeleteThis - repeat this test for every user role that has access and all valid control flows
    test 'Should destroy when logged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      assert_difference 'ChangeModel.count', -1 do
        delete ChangePath_path(id: @ChangeObject.id), params: destroy_params, xhr: true
      end
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      assert flash[:success]
      assert_raise 'ActiveRecord::RecordNotFound' do
        @ChangeObject.reload
      end
      # DeleteThis - insert at least one assertions per line of code in control flow
    end

    # DeleteThis - NOTE: often there is no invalid flow for destroy. If that is the case, remove invalid flow test below
    # DeleteThis - repeat test for all invalid control flows.
    # DeleteThis - NOTE: this only needs to be tested for one user role (we're testing invalid flows, not authorization)
    # DeleteThis - NOTE: this also only needs to be tested for one invalid - we are testing control flow, not all model validations)
    test 'Should not destroy when params are invalid' do
      sign_in(@ChangeUserWithPermission)
      invalid_destroy_params = destroy_params
      invalid_destroy_params[:ChangeScope][:ChangeAttribute] = ChangeInvalidValue
      assert_no_difference 'ChangeModel.count' do
        delete ChangePath_path(id: @ChangeObject.id), params: invalid_destroy_params, xhr: true
      end
      # DeleteThis - use assert_response :success or assert_response :redirect and delete whatever is not used
      assert_response :success
      assert_template 'ChangeTemplate'
      assert_response :redirect
      assert_redirected_to ChangePath
      assert flash[:danger]
      assert_nothing_raised do
        @ChangeObject.reload
      end
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
