class WeeklyProgramsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:download]
  before_action :set_weekly_program, only: [:show, :edit, :update, :destroy, :publish, :download]

  def index
    @weekly_programs = WeeklyProgram.order(week_start: :desc).paginate(:page => params[:page], :per_page => 10)
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

  def edit

  end

  def update
    if @weekly_program.update(weekly_program_params)
      redirect_to @weekly_program, notice: 'Weekly program was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @weekly_program.destroy
    redirect_to weekly_programs_url
  end

  def show

  end

  def download
    respond_to do |format|
      format.pdf do
        weekly_program_printer = WeeklyProgramPrinter.new(@weekly_program)
        send_data weekly_program_printer.render, filename: "WeeklyProgramOn#{@weekly_program.week_start}",  type: 'application/pdf'
      end
    end
  end

  def publish
    published = params[:published].eql?('false') ? false : true
    @weekly_program.published = published
    @weekly_program.save

    publish_note = published ? 'published': 'removed from public'

    redirect_to @weekly_program, notice: 'Weekly program was successfully ' + publish_note
  end

  private
  def set_weekly_program
    @weekly_program = WeeklyProgram.find(params[:id])
  end

  def weekly_program_params
    params.require(:weekly_program).permit(:week_start, :program_staff, :theme, :goals, :letter, :number, :shape, :colour, :published)
  end
end
