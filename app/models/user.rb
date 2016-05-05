class User < ActiveRecord::Base
  has_many :carts
  belongs_to :current_cart, :class_name => "Cart"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def create_current_cart
    #instantiate a new cart
      #built off the user => get user_id
      #saves through create
    new_cart = self.carts.create
    self.current_cart_id = new_cart.id
    self.save
  end

  def close_current_cart
    self.current_cart_id = nil
    self.save
  end

end
