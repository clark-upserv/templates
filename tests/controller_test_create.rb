    test 'Should create when ChangeThisPls' do
      sign_in(@ChangeUserWithPermission)
      post ChangeUrl_url(id: @ChangeObject.id), params: create_params, xhr: true
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

    test 'Should not create when params are invalid' do
      sign_in(@ChangeUserWithPermission)
      invalid_create_params = create_params
      invalid_create_params[:ChangeScope][:ChangeAttribute] = ChangeInvalidValue
      post ChangeUrl_url(id: @ChangeObject.id), params: invalid_create_params, xhr: true
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
