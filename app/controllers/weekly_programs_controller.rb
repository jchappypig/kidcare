class WeeklyProgramsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @weekly_programs = WeeklyProgram.all
  end

  def new
    @weekly_program = WeeklyProgram.new
  end

  def create
    @weekly_program = WeeklyProgram.new(weekly_program_params)

    if @weekly_program.save
      redirect_to weekly_program_activity_selection_path(@weekly_program), notice: 'Weekly program was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def set_weekly_program
    @weekly_program = WeeklyProgram.find(params[:id])
  end

  def weekly_program_params
    params.require(:weekly_program).permit(:week_start, :program_staff, :theme, :goals, :letter, :number, :shape, :colour)
  end
end
