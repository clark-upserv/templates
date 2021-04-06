# frozen_string_literal: true

# rails t test/controllers/ChangePathToTest_controller_test.rb
require 'test_helper'

module ChangeThisPls
  # Tests for ChangeThisPls Controller
  class ChangeThisPlsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
      @base_user = core_users(:base_user)
      @ChangePermission_user = core_users(:ChangeUserWithPermission)
      @ChangeThisPls = change_model_name(:ChangeModel)
    end
  end
end
