# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThisPls
  # helper test for ChangeThisPlsHelper
  class ChangeThisPlsHelperTest < ActionDispatch::IntegrationTest
    setup do
      @ChangeThisPls = change_model_name(:ChangeFixture)
    end

    test disclaimer
  end
end
