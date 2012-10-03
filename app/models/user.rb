class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :name, :login, :password, :password_confirmation

  validates :name, presence: true
  validates :login, presence: true

end
