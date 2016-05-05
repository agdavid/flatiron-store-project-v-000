require 'pry'

class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    #iterate over all the line_items in a cart
    self.line_items.collect do |line_item|
      #for each item get the price
      item_price = Item.find(line_item.item_id).price
      #for each item get the quantity
      item_quantity = line_item.quantity
      #get the total and collect into an array
      item_total = (item_price*item_quantity)
      #use #inject to sum all the totals in the array
    end.inject(0){|sum,x| sum + x }
  end

  def add_item(new_item_id)
    #if that item is already in the cart (i.e., matching cart and item ids)
      #calling self.line_items => matches on cart_id
      #then calling find_by => matches on item_id
    if existing_line_item = self.line_items.find_by(item_id: new_item_id)
      #increase the quantity, but don't duplicate the row
      existing_line_item.quantity +=1
      existing_line_item
    else
      #make a new line item
      self.line_items.build(item_id: new_item_id)
    end
  end
    #line_item schema
      # t.integer  "cart_id"
      # t.integer  "item_id"
      # t.integer  "quantity",   default: 1

    ### CHECKOUT METHODS ###
    def update_inventory_and_status
      self.update_inventory
      self.update_status  
    end

    def update_inventory
      #go through each line_item of the current_cart
      self.line_items.each do |line_item|
        #find the item
        actual_item = Item.find(line_item.item_id)
        #find the quantity purchased
        quantity_purchased = line_item.quantity
        #reduce inventory
        actual_item.inventory -= quantity_purchased
        actual_item.save
      end
    end

    def update_status
      self.status = "submitted"
      self.save
    end

end
