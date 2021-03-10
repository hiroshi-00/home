class User < ApplicationRecord
  has_many :reviews
  has_many :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end
end
