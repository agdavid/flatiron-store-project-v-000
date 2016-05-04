class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :carts, through: :line_items

  def self.available_items
    where("inventory > ?", 0)
  end

end

    # t.integer  "inventory"
    # t.string   "title"
    # t.integer  "price"
    # t.integer  "category_id"
    # t.datetime "created_at",  null: false
    # t.datetime "updated_at",  null: false
