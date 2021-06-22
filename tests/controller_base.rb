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
      @dif_account_user = core_users(:dif_account_user)
      @ChangeObject = change_model_name(:ChangeModel)
      @dif_account_ChangeObject = change_model_name(:ChangeModel)
    end

    test disclaimer
  end
end
