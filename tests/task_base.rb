# frozen_string_literal: true

# rails t ChangePathAndFileName
require 'test_helper'
require 'rake'

module ChangeThisPls
  # Tests that ChangeThisPls
  class ChangeThisPlsTaskTest < ActiveSupport::TestCase
    test disclaimer
    test 'Should ChangeExpectedAction when the ChangeTaskName task is invoked' do
      @ChangeObject = ChangeTableName(:ChangeFixtureName)
      # DeleteThis - this line (below) loads tasks but only if they are not already loaded
      ChangeApplicationName::Application.load_tasks if Rake::Task.tasks.empty?
      # DeleteThis - this line (below) calls the actual task
      Rake::Task['ChangeTaskName'].invoke
      @ChangeObject.relaod
      # DeleteThis - insert at least one assertions per line of code in control flow
    end
  end
end
