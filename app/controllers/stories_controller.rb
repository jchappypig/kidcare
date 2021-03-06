require 'prawn'

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:download]
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  def index
    @stories = Story.order(time_line: :desc).paginate(:page => params[:page], :per_page => 5)
  end

  # GET /stories/1
  def show
    @story_attachments = StoryAttachment.where(guid: @story.guid)
  end

  def download
    respond_to do |format|
      format.pdf do
        date = params[:date]
        stories_printer = StoriesPrinter.new(date)
        send_data stories_printer.render, filename: "StoriesOn#{date}",  type: 'application/pdf'
      end
    end
  end

  # GET /stories/new
  def new
    @story = Story.new
    @story.guid = SecureRandom.uuid
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    if params[:story_attachments].present? && !params[:story_attachments][:photo][0].to_s.empty?
      params[:story_attachments][:photo].each do |photo|
        StoryAttachment.create!(photo: photo, guid: @story.guid)
      end
      redirect_to preview_our_stories_path(date: @story.time_line), notice: 'Story was successfully created.'
    else
      if @story.save
        recruit_orphan_attachments
        redirect_to @story, notice: 'Story was successfully created.'
      else
        render action: 'new'
      end
    end
  end

  def recruit_orphan_attachments
    StoryAttachment.where(guid: @story.guid, story_id: nil).update_all(story_id: @story)
  end

# PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      params[:story_attachments][:photo].each do |photo|
        StoryAttachment.create!(photo: photo, story_id: @story.id, guid: @story.guid)
      end if (params[:story_attachments].present?)
      redirect_to preview_our_stories_path(date: @story.time_line), notice: 'Story was successfully updated.'
    else
      render action: 'edit'
    end
  end

# DELETE /stories/1
  def destroy
    @story.destroy
    redirect_to stories_url
  end

  def publish
    date = params[:date]
    if date.present?
      published = params[:published].eql?('false') ? false : true
      Story.where(time_line: date).update_all(published: published)

      publish_note = published ? 'published': 'removed from public'

      redirect_to preview_our_stories_path(date: date), notice: 'Stories were successfully ' + publish_note
    else
      redirect_to preview_our_stories_path
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = Story.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def story_params
    params.require(:story).permit(:content, :time_line, :guid, :published, outcome_ids: [], story_attachments_attributes: [:id, :story_id, :photo])
  end
end
