class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_activity, only: [:edit, :update, :destroy]

  def new
    @activity = Activity.new
    @activity.weekly_program_id = params[:weekly_program_id]
    @activity.category = params[:category]
  end

  def activity_selection
    @weekly_program_id = params[:weekly_program_id]
  end

  def create
    @activity = Activity.new(activity_params.merge(weekly_program_id: params[:weekly_program_id]))

    if(@activity.save)
      redirect_to weekly_program_path(params[:weekly_program_id]), notice: 'Activity was successfully created.'
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    if ((@activity.weekly_program_id.to_s.eql? params[:weekly_program_id]) && @activity.update(activity_params))
      redirect_to weekly_program_path(params[:weekly_program_id]), notice: 'Weekly program was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:category, :day, :cross_mentor, :cross_mentor_outcome,
                                     :social, :social_outcome, :art_and_craft, :art_and_craft_outcome, :language,
                                     :language_outcome)
  end
end
