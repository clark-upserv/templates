# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThisPls
  # Tests for ChangeThisPlsController
  class ChangeThisPlsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @base_user = core_users(:base_user)
      @ChangeUserWithPermission_user = core_users(:ChangeUserWithPermission)
      @ChangeObject = change_model_name(:ChangeModel)
    end

    # DeleteThis - reset cache (for example, to remove current_user) )after each test if necessary (remove this is it is not necessary)
    teardown do
      Rails.cache.clear
    end
    
    test disclaimer
  end
end
