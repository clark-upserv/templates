# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThisPls
  # Integration test for ChangeThisPls
  class ChangeThisPlsTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @ChangeThisPls = change_model_name(:ChangeFixture)
    end

    # DeleteThisIfNotNecessary - reset cache (for example, to remove current_user) )after each test if necessary (remove this is it is not necessary)
    teardown do
      Rails.cache.clear
    end

    test disclaimer
  end
end
