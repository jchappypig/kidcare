class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng
  before_action :authenticate_user!, only: [:our_stories]

  def index
  end

  def contact_us
  end

  def our_stories
    time_line = params[:date] || Date.today
    @stories = Story.where(time_line: time_line)


    if(!@stories || @stories.empty?)
      @stories = Story.where(time_line: Date.today)
    end
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
