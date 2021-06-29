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

    test disclaimer
  end
end
