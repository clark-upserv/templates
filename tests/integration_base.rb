# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThisPls
  # Integration test for ChangeThisPls
  class ChangeThisPlsTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @ChangeThisPls = change_model_name(:ChangeModel)
    end

    # DeleteThisIfNotNecessary - reset cache after each test
    teardown do
      Rails.cache.clear
    end
  end
end
