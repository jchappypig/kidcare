class WhiteListsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_white_list, only: [:show, :edit, :update, :destroy]

  def index
    @white_lists = WhiteList.order(:email)
  end

  def show
  end

  def new
    @white_list = WhiteList.new
  end

  def edit
  end

  def create
    @white_list = WhiteList.new(white_list_params)

    if @white_list.save
      redirect_to @white_list, notice: 'White list was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @white_list.update(white_list_params)
      redirect_to @white_list, notice: 'White list was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @white_list.destroy
    redirect_to white_lists_url
  end

  private
  def set_white_list
    @white_list = WhiteList.find(params[:id])
  end

  def white_list_params
    params.require(:white_list).permit(:email)
  end
end
