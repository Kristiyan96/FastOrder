# frozen_string_literal: true
class Dashboard::PositionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_restaurant
  before_action :set_position, only: [:show, :edit, :destroy]

  def index
    @positions = @restaurant.positions
    @positions = @positions.search(params[:search])
    @positions = @positions.page(params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @positions }
      format.js { render partial: 'index' }
    end
  end

  def show
  end

  def new
    @position = @restaurant.positions.build
    @roles = @restaurant.roles

    respond_to do |format|
      format.js { render partial: 'form.js.coffee' }
    end
  end

  def edit
    @roles = @restaurant.roles
    @editing = true

    respond_to do |format|
      format.js { render partial: 'form.js.coffee' }
    end
  end

  def create
    @employee = User.find_by(email: params[:email])
    params[:position][:user_id] = @employee.id

    @position = @restaurant.positions.new(position_params)

    respond_to do |format|
      if @position.save
        format.html do
          redirect_to dashboard_restaurant_positions_path(@restaurant),
                      notice: 'Employee was successfully added.',
                      status: :created
        end
        format.js
      else
        format.html { render :new }
        format.json { render json: @position.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html do
          redirect_to dashboard_restaurant_position_path(@restaurant, @position),
                      notice: 'Employee status was successfully updated.',
                      status: :ok
        end
        format.js
      else
        format.html { render :edit }
        format.json { render json: @position.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_restaurant_positions_path(@restaurant), flash: { notice: 'Employee was successfully removed.' } }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.friendly.find(params[:restaurant_id])
  end

  def set_position
    @position = @restaurant.positions.find(params[:id])
  end

  def position_params
    params.require(:position).permit(:role_id, :user_id)
  end
end
