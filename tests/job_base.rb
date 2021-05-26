# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'

module ChangeThisPls
  # Tests for ChangeThisPlsJob
  class ChangeThisPlsJobTest < ActiveJob::TestCase
    setup do
      @base_user = core_users(:base_user)
    end

  end
end
