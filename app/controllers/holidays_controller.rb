class HolidaysController < ApplicationController
  before_action :signed_in_user

  # GET /holidays
  # GET /holidays.json
  def index
    @holiday = current_user.holidays.all
  end

  # GET /holidays/1
  # GET /holidays/1.json
  def show
  end

  # GET /holidays/new
  def new
    @user = current_user
    @holiday = current_user.holidays.build

    respond_to do |format|
      format.html
    end
  end

  # GET /holidays/1/edit
  def edit
    @holiday = Holiday.find params[:id]
  end

  # POST /holidays
  # POST /holidays.json
  def create
    @holiday = current_user.holidays.build(holiday_params)
    @holiday.start_date = Date.parse(params[:holiday][:start_date]) unless params[:holiday][:start_date].blank?
    @holiday.end_date = Date.parse(params[:holiday][:end_date]) unless params[:holiday][:end_date].blank?
    if @holiday.save
      flash[:success] = "holiday created!"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  # PATCH/PUT /holidays/1
  # PATCH/PUT /holidays/1.json
  def update
     @holiday = Holiday.find params[:id]
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to current_user, notice: 'Holiday was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.json
  def destroy
       Holiday.find(params[:id]).destroy
    flash[:success] = "Holiday deleted."
    redirect_to current_user
  end

  def accept
    holiday = Holiday.find(params[:id])
    holiday.accept!
    redirect_to user_path(current_user)
  end

  def decline
    holiday = Holiday.find(params[:id])
    holiday.decline!
    redirect_to user_path(current_user)
  end

  private

    def holiday_params
      params.require(:holiday).permit(:start_date, :end_date)
    end
end
