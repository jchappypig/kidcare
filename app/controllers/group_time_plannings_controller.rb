class GroupTimePlanningsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_group_time_planning, only: [:edit, :update, :destroy]

  def clone
    if (params[:category].present?)
      reference_group_time_planning = GroupTimePlanning.where(category: params[:category]).last
    else
      reference_group_time_planning = GroupTimePlanning.last
    end

    if reference_group_time_planning.nil?
      @group_time_planning = GroupTimePlanning.new
    else
      @group_time_planning = reference_group_time_planning.dup
    end

    @group_time_planning.weekly_program_id = params[:weekly_program_id]
  end

  def new
    @group_time_planning = GroupTimePlanning.new
    @group_time_planning.weekly_program_id = params[:weekly_program_id]
  end

  def create
    @group_time_planning = GroupTimePlanning.new(group_time_planning_params.merge(weekly_program_id: params[:weekly_program_id]))

    if (@group_time_planning.save)
      redirect_to weekly_program_path(params[:weekly_program_id]), notice: 'Group time activity was successfully created.'
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    if ((@group_time_planning.weekly_program_id.to_s.eql? params[:weekly_program_id]) && @group_time_planning.update(group_time_planning_params))
      redirect_to weekly_program_path(params[:weekly_program_id]), notice: 'Group time activity was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @group_time_planning.destroy
    redirect_to weekly_program_path(params[:weekly_program_id]), notice: 'Group time activity was successfully deleted.'
  end
  
  private
  def set_group_time_planning
    @group_time_planning = GroupTimePlanning.find(params[:id])
  end

  def group_time_planning_params
    params.require(:group_time_planning).permit(:day, :morning, :late_morning, :afternoon, :late_afternoon, :finishing_up)
  end
end
