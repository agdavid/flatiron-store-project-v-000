class CartsController < ApplicationController

  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    #params gives you "id" => "2" which belongs to the cart
    @cart = Cart.find(params[:id])
    @cart.update_inventory_and_status
    current_user.update_current_cart_status
    if @cart.save
      redirect_to cart_path(@cart), :notice => "Checkout successful."
    else
      redirect_to cart_path(@cart), :notice => "Unable to checkout"
    end
  end
end
