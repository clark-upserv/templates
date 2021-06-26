# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'
require 'test_helpers/ChangePathToTestHelpeBeingTested'

module ChangeThisPls
  # helper test for ChangeThisPlsTestHelper
  class ChangeThisPlsTestHelperTest < ActionDispatch::IntegrationTest
    setup do
      @ChangeThisPls = change_model_name(:ChangeFixture)
    end

    test disclaimer
  end
end
