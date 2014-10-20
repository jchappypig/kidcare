class WaitingListsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :authenticate_admin!, except: [:new, :create]
  before_action :set_waiting_list, only: [:show, :edit, :update, :destroy]

  def index
    @waiting_lists = WaitingList.order(:child_full_name).paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @waiting_list = WaitingList.new
  end

  def edit
  end

  def create
    @waiting_list = WaitingList.new(waiting_list_params)

    if @waiting_list.save
      current_user.try(:admin?) ?
          (redirect_to @waiting_list, notice: 'Waiting list was successfully created.') : (redirect_to root_path)
    else
      render action: 'new'
    end
  end

  def update
    if @waiting_list.update(waiting_list_params)
      redirect_to @waiting_list, notice: 'Waiting list was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @waiting_list.destroy
    redirect_to waiting_lists_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_waiting_list
    @waiting_list = WaitingList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def waiting_list_params
    params.require(:waiting_list).permit(:child_full_name, :child_dob, :parent_full_name, :home_phone, :mobile_phone, :address, :intend_start_date, days_required: [])
  end
end
