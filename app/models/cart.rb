class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    #SELECT sum(price) as total FROM items WHERE
    #JOIN line_items ON line_item.cart_id = cart.id
    #JOIN items ON item.id = line_item.item_id
    self.items.sum("price")
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
end
