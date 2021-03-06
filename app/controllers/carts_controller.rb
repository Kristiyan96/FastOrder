# frozen_string_literal: true
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order_items = current_order.order_items.order('created_at')

    @restaurant = current_order.restaurant
    add_breadcrumb @restaurant.name, restaurant_path(@restaurant), title: "Back to the restaurant"
    add_breadcrumb "menu", restaurant_path(@restaurant, menu: "open"), title: "Back to menu"
    add_breadcrumb "cart"
  end
end
