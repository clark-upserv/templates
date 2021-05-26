# frozen_string_literal: true

# rails t ChangePathAndFileName
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
    test disclaimer
  end
end
