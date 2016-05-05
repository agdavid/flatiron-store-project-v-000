class CartsController < ApplicationController

  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    #params gives you "id" => "2" which belongs to the cart
    @cart = Cart.find(params[:id])
    @cart.update_inventory
    current_user.close_current_cart
    if @cart.save
      redirect_to cart_path(@cart), :notice => "Checkout successful."
    else
      redirect_to cart_path(@cart), :notice => "Unable to checkout"
    end
  end
end
