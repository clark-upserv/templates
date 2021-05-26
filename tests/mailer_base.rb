# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThis
  # Tests for ChangeThisMailer
  class ChangeThisMailerTest < ActionMailer::TestCase
    setup do
      @ChangeObject = change_model_name(:ChangeFixture)
    end
    
    add mailer test
  end
end
