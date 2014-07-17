class WaitingListsController < ApplicationController
  before_action :set_waiting_list, only: [:show, :edit, :update, :destroy]

  # GET /waiting_lists
  # GET /waiting_lists.json
  def index
    @waiting_lists = WaitingList.all
  end

  # GET /waiting_lists/1
  # GET /waiting_lists/1.json
  def show
  end

  # GET /waiting_lists/new
  def new
    @waiting_list = WaitingList.new
  end

  # GET /waiting_lists/1/edit
  def edit
  end

  # POST /waiting_lists
  # POST /waiting_lists.json
  def create
    @waiting_list = WaitingList.new(waiting_list_params)

    respond_to do |format|
      if @waiting_list.save
        format.html { redirect_to @waiting_list, notice: 'Waiting list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @waiting_list }
      else
        format.html { render action: 'new' }
        format.json { render json: @waiting_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waiting_lists/1
  # PATCH/PUT /waiting_lists/1.json
  def update
    respond_to do |format|
      if @waiting_list.update(waiting_list_params)
        format.html { redirect_to @waiting_list, notice: 'Waiting list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @waiting_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waiting_lists/1
  # DELETE /waiting_lists/1.json
  def destroy
    @waiting_list.destroy
    respond_to do |format|
      format.html { redirect_to waiting_lists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waiting_list
      @waiting_list = WaitingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waiting_list_params
      params.require(:waiting_list).permit(:child_name, :child_age, :parent_name, :phone, :address, :postcode, :expect_join_time, :days_per_week)
    end
end
