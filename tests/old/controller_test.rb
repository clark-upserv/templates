replace:
user_with_access
model
Model
resources
namespace
NameSpace


# rails t test/controllers/namespace/resources_controller_test.rb


  include Devise::Test::IntegrationHelpers

  #--- Setup ---#
  def setup
    # @base_user = core_users(:base_user)
    # @user_with_access = core_users(:user_with_access)
    # @model = namespace_resources(:model_1)
    # @dif_account_model = namespace_resources(:dif_account_model)
  end

  #--- Index ---#
  test "should not get index when not logged in" do
    # assert_raise do
      get namespace_resources_path
    # end
  end

  test "should not get index when logged in as base user" do
    sign_in @base_user
    # assert_raise do
      get namespace_resources_path
    # end
  end

  test "should get index only with same account resources when logged in as user_with_access" do
    sign_in @user_with_access
    get namespace_resources_path
    assert_response :success
    assert_template 'namespace/resources/index'
    assert assigns(:resources).include?(@model)
    assert_not assigns(:resources).include?(@dif_account_model)
  end

  #--- Show ---#
  test "should not get show when not logged in" do
    # assert_raise do
      get namespace_model_path(@model)
    # end
  end

  test "should not get show when logged in as base user" do
    sign_in @base_user
    # assert_raise do
      get namespace_model_path(@model)
    # end
  end

  test "should get show for same account model when logged in as user_with_access" do
    sign_in @user_with_access
    get namespace_model_path(@model)
    assert_response :success
    assert_template 'namespace/resources/show'
    assert_equal @model, assigns(:model)
  end

  test "should not get show for different account model nwhen logged in as user_with_access" do
    sign_in @user_with_access
    # assert_raise do
      get namespace_model_path(@dif_account_model)
    # end
  end

  #--- New ---#
  test "should not get new when not logged in" do
    # assert_raise do
      get new_namespace_model_path
    # end
  end

  test "should not get new when logged in as base user" do
    sign_in @base_user
    # assert_raise do
      get new_namespace_model_path
    # end
  end

  test "should get new with same account model when logged in as user_with_access" do
    sign_in @user_with_access
    get new_namespace_model_path
    assert_response :success
    assert_template 'namespace/model/new'
    # NOTE: we have to do new.attributes because assert_equal doesn't play nicely with "new" instances.
    assert_equal NameSpace::Model.new.attributes, assigns(:model).attributes
  end
  
  # if account can be called in new, test "should not get new for different account model when logged in as user_with_access"
  # if new is  account agnostic add comment:
  # not testing scope for new (ie user_with_access cannot get new for model on diferent account) because the new page is account agnostic

  #--- Create ---#
  test "shoud not create when not logged in" do
    # assert_raise do
      post namespace_resources_path, params: { namespace_model: { [see create params attributes] } }
    # end 
  end

  test "should not create when logged in as base" do
    sign_in @base_user
    # assert_raise do
      post namespace_resources_path, params: { namespace_model: { [see create params attributes] } }
    # end 
  end

  test "should create when logged in as user_with_access" do
    sign_in @user_with_access
    assert_difference 'NameSpace::Model.count', 1 do
      post namespace_resources_path, params: { namespace_model: { [see create params attributes] } }
    end
  end

  # if account is in create params, test for account
  test "should not create for different account when logged in as user_with_access" do
    sign_in @user_with_access
    # assert_raise do
      post namespace_resources_path, params: { namespace_model: { [see create params attributes & make account related param for a different account] } }
    # end
  end
  # if create params are account agnostic add comment:
  # not testing for creating model on different account because create params are account agnostic

  #--- Edit ---#
  test "should not get edit when not logged in" do
    # assert_raise do
      get edit_namespace_model_path(@model)
    # end
  end

  test "should not get edit when logged in as base user" do
    sign_in @base_user
    # assert_raise do
      get edit_namespace_model_path(@model)
    # end
  end
  
  test "should get edit when logged in as user_with_access" do
    sign_in @user_with_access
    get edit_namespace_model_path(@model)
    assert_response :success
    assert_template 'namespace/resources/edit'
    assert_equal @model, assigns(:model)
  end

  test "should not get edit for different account when logged in as user_with_access" do
    sign_in @user_with_access
    # assert_raise do
      get edit_namespace_model_path(@dif_account_model)
    # end
  end

  #--- Update ---#
  test "shoud not update when not logged in" do
    # assert_raise do
      patch namespace_model_path(@model), params: { namespace_model: { [see update params attributes] } }
    # end 
  end

  test "should not update when logged in as base" do
    sign_in @base_user
    # assert_raise do
      patch namespace_model_path(@model), params: { namespace_model: { [see update params attributes] } }
    # end 
  end

  test "should update when logged in as user_with_access" do
    sign_in @user_with_access
    patch namespace_model_path(@model), params: { namespace_model: { [see update params attributes] } }
    @model.reload
    assert_equal "[updated attribute value]", @model.attribute
  end

  test "should not update model on different account" do
    sign_in @user_with_access
    # assert_raise do
      patch namespace_model_path(@dif_account_model), params: { namespace_model: { [see update params attributes] } }
    # end
  end

  #--- Destroy ---#
  test "shoud not destroy when not logged in" do
    # assert_raise do
      delete namespace_model_path(@model)
    # end
  end

  test "should not destroy when logged in as base" do
    sign_in @base_user
    # assert_raise do
      delete namespace_model_path(@model)
    # end
  end


  # if actual destroy
  test "should destroy when logged in as namespace admin" do
    sign_in @user_with_access
    assert_difference 'NameSpace::Model.count', -1 do
      delete namespace_model_path(@model)
    end
    assert flash.any?
  end

  # if deactivate destroy
  test "should destroy when logged in as namespace admin" do
    sign_in @user_with_access
    # cannot actually delete a model. It actually only "deactivates" the model
    delete namespace_model_path(@model)
    # assert deactivated
    assert @model.reload.deactivated?
    assert flash.any?
  end

  test "should not destroy model on different account" do
    sign_in @user_with_access
    assert_raise do
      delete namespace_model_path(@dif_account_model)
    end
  end

  #--- Strong Params ---#
  test "create params" do 
    sign_in @user_with_access
    post namespace_resources_path, params: { namespace_model: { [attributes + non-permitted attributes] } }
    assert_equal submitted_attribute_value, assigns(:model).permitted_attribute
    assert_not_equal submitted_attribute_value, assigns(:model).non_permitted_attribute
    assert_equal controller_set_attribute_value, assigns(:model).non_permitted_attribute 
  end

  test "update params" do 
    sign_in @user_with_access
    previous_attribute_value = @model.previous_attribute
    patch namespace_model_path(@model), params: { namespace_model: { [attributes + non-permitted attributes] } }
    @model.reload
    # assert permitted value was updated
    assert_equal submitted_attribute_value, @model.permitted_attribute
    # assert non permittited value is not the submitted value
    assert_not_equal submitted_attribute_value, @model.non_permitted_attribute
    # assert non permitted value is the same as the previous value
    assert_equal previous_attribute_value, @model.non_permitted_attribute 
  end

  #--- Before Methods ---#
  #--- Controller Methods ---#

