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
class Training::ChapterOrdersController < ApplicationController
  # authorize only because we are not loading a chapter, but rather a course
  authorize_resource class: Training::Course

  def update
    # set course for which to sort chapters (from hidden field on form)
    @course = Training::Course.accessible_by(current_ability, :edit).find(params[:training_course_id])
    # make sure the chapter ids have not been altered by the scary internet (otherwise only non-altered ids would be sorted and you could end up with duplicate positions)

    # reposition each chapter on the course based on the position within the parms[:training_chapter_ids] array. NOTE: this will only check for ids that are an id that belong to a chapter on the current @course (read the code)
    @course.chapters.where(deactivated: false).each do |chapter|
      # set new position to be the array position + 1 (array 0 start adjustment)
      new_position = params[:training_chapter_ids].find_index(chapter.id.to_s) + 1
      # update the chapter and skip validaitons (update column) because for a split second there will be duplicate positions
      chapter.update_column(:position, new_position)
    end

    respond_to do |format|
      # for tests
      format.html { redirect_to edit_training_course_url(@course) }
      # ajax response
      format.js { }
    end
  end
end
a
