# frozen_string_literal: true

module Change
  # Change
  class ChangeController < ApplicationController

    private

    def Change_params
      params.require('Change').permit(:Change)
    end
  end
end
