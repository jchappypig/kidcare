class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def new

  end

  private
  def story_params
    params.require(:story).permit(:content, :time_line, :guid, outcome_ids: [], story_attachments_attributes: [:id, :story_id, :photo])
  end
end
