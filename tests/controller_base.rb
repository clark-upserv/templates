# frozen_string_literal: true

# rails t test/controllers/ChangePathToTest_controller_test.rb
require 'test_helper'

module ChangeThisPls
  # Tests for ChangeThisPls Controller
  class ChangeThisPlsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @base_user = core_users(:base_user)
      @ChangeUserWithPermission = core_users(:ChangeUserWithPermission)
      @ChangeThisPls = change_model_name(:ChangeModel)
    end

    # DeleteThisIfNotNecessary - reset cache after each test
    teardown do
      Rails.cache.clear
    end
  end
end
