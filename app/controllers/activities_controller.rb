class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def new
    @activity = Activity.new
    @activity.weekly_program_id = params[:weekly_program_id]
    @activity.category = params[:category]
  end

  def activity_selection
    @weekly_program_id = params[:weekly_program_id]
  end

  def create

  end

  private
  def activity_params
    params.require(:activity).permit(:weekly_program_id, :category)
  end
end
