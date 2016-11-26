# frozen_string_literal: true
class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:favorite]
  before_action :set_restaurant, only: [:show, :favorite]

  def index
    @user_location = request.location
    
    @restaurants = Restaurant.search(params[:search])
    @restaurants = @restaurants.by_distance(origin: [@user_location.latitude, @user_location.longitude]) if !@user_location.blank?
    @restaurants = @restaurants.page(params[:page]).per(12)

    # Checking if called by pagination or by a new search
    @nextpage = params[:scrolling]
    params[:scrolling] = false
    # Checking if should show index page
    @html = request.format.html?



    respond_to do |format|
      format.html
      format.json { render json: @restaurants }
      format.js
    end
  end

  def show
    session[:restaurant_id] = @restaurant.id
    @hash = Gmaps4rails.build_markers(@restaurant) do |res, marker|
      marker.lat res.latitude
      marker.lng res.longitude
    end

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant), title: "Back to the restaurant"
  end

  def favorite
    type = params[:type]
    if type == 'favorite'
      current_user.favorite_restaurants << @restaurant
    else
      current_user.favorite_restaurants.delete(@restaurant)
    end

    respond_to do |format|
      format.html
      format.js { render partial: 'favorite.js.erb' }
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.friendly.find(params[:id])
  end
end