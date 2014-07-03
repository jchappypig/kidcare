class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  def index
    @stories = Story.all
  end

  # GET /stories/1
  def show
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
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
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
    params.require(:story).permit(:title, :content, :time_line)
  end
end