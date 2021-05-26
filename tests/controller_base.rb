# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThisPls
  # Tests for ChangeThisPlsController
  class ChangeThisPlsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @base_user = core_users(:base_user)
      @ChangeUserWithPermission = core_users(:ChangeUserWithPermission)
      @ChangeThisPls = change_model_name(:ChangeModel)
    end

    # DeleteThis - include tear down ONLY if necessary (ex. to reset cache after each test if you need to remove current user)
    # DeleteThis - otherwise, remove teardown
    teardown do
      Rails.cache.clear
    end

  end
end
