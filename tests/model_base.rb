# frozen_string_literal: true

# rails t test/models/ChangePathToTest_test.rb
require 'test_helper'

module ChangeThisPls
  # Tests for ChangeThisPls model
  class ChangeThisPlsTest < ActiveSupport::TestCase
    setup do
      @ChangeModel = change_model_name(:ChangeModel)
    end

    # initial valid test
    test 'valid ChangeModel' do
      assert @ChangeModel.valid?
    end
  end
end