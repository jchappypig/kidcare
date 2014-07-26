class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  def index
    @stories = Story.all.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /stories/1
  def show
    @story_attachments = @story.story_attachment.all
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    if @story.save
      params[:story_attachments][:photo].each do |photo|
        StoryAttachment.create!(photo: photo, story_id: @story.id)
      end if (params[:story_attachments].present?)
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render action: 'new'
    end
  end

# PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      params[:story_attachments][:photo].each do |photo|
        StoryAttachment.create!(photo: photo, story_id: @story.id)
      end if (params[:story_attachments].present?)
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render action: 'edit'
    end
  end

# DELETE /stories/1
  def destroy
    @story.destroy
    redirect_to stories_url
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = Story.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def story_params
    params.require(:story).permit(:content, :time_line, outcome_ids: [], story_attachments_attributes: [:id, :story_id, :photo])
  end
end
