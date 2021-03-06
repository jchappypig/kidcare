class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng
  before_action :authenticate_user!, only: [:our_stories, :our_weekly_program, :preview_our_stories]
  before_action :authenticate_admin!, only: [:preview_our_stories]

  def index
    @story
  end

  def contact_us
  end

  def about_us
  end

  def our_weekly_program
    @weekly_program = WeeklyProgram.order(week_start: :desc).find_by(published: true)
  end

  def our_stories
    datesAvailable = Story.where(published: true).order(:time_line).pluck('DISTINCT time_line')
    date = getStoryDate(datesAvailable)

    @stories = Story.where(time_line: date, published: true)
    if !@stories.empty?
      current_date_index = datesAvailable.index(date)
      @last_story_date = (current_date_index == 0 ? nil : datesAvailable[current_date_index - 1])
      @next_story_date = (current_date_index == (datesAvailable.size - 1) ? nil : datesAvailable[current_date_index + 1])
    end
  end

  def preview_our_stories
    datesAvailable = Story.order(:time_line).pluck('DISTINCT time_line')
    date = getStoryDate(datesAvailable)

    @stories = Story.where(time_line: date)
    if !@stories.empty?
      current_date_index = datesAvailable.index(date)
      @last_story_date = (current_date_index == 0 ? nil : datesAvailable[current_date_index - 1])
      @next_story_date = (current_date_index == (datesAvailable.size - 1) ? nil : datesAvailable[current_date_index + 1])
    end
  end

  def getStoryDate(datesAvailable)
    begin
      date = Date.parse(params[:date].to_s)
    rescue ArgumentError
      date = datesAvailable.last
    end

    if (!datesAvailable.include?(date))
      date = datesAvailable.last
    end
    date
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def authenticate_admin!
    unless current_user.try(:admin?)
      flash[:alert] = 'You are not authorized to view this page.'
      redirect_to root_path
    end
  end
end
