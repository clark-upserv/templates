    # DeleteThis - repeat this test for every user role that has access and all control flows
    test 'Should index when loged in as ChangeUserWithPermission' do
      sign_in(@ChangeUserWithPermission)
      get ChangeUrlHelper_path
      assert_response :success
      assert_template 'index'
      assert_equal ChangeModel.where(ChangeQuery).pluck(:id), assigns(:ChangeLoad).map(&:id).sort
      assert_not_includes assigns(:ChangeLoad), @ChangeDifAccountObject
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
