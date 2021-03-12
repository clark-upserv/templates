# frozen_string_literal: true

module ChangeThisPls
  # ChangeThisPls
  class ChangeThisPlsController < ApplicationController

    private

    def ChangeThisPls_params
      params.require('ChangeThisPls').permit(:ChangeThisPls)
    end
  end
end
