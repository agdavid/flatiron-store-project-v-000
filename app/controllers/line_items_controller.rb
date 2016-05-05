class LineItemsController < ApplicationController
  def create
    #action hit after user presses "Add to Cart"
    #params gives you "item_id" => "1" (or whatever item_id)
    #1. want to check for current_cart, if none then create
    #2. then want to create this line_item and put it in the cart
    #3. then you want to redirect to the cart show page
    current_user.create_current_cart unless current_user.current_cart
    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      redirect_to cart_path(current_user.current_cart), {notice: 'Item added to cart!'}
    else
      redirect_to store_path, {notice: 'Unable to add item'}
    end
  end
end
