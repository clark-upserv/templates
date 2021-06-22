    # DeleteThis - repeat this test for every user role that has access and all control flows
    test 'Should show when loged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      get ChangeUrlHelper_path(id: @ChangeObject.id)
      assert_response :success
      assert_template 'show'
      assert_equal ChangeModel.where(id: @ChangeObject.id).pluck(:id).first, assigns(:ChangeLoad).id
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
