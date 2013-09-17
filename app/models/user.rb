class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone_number

  has_many :health_condition_subscriptions, :autosave => true

  validates :name, :length => {:maximum => 50}

  def phone_number_country_code
    phone_number.to_s[0]
  end

  def phone_number_country_code=(country_code)
    phone_number
  end

  def phone_number_area_code
    phone_number.to_s[1..3]
  end

  def phone_number_suffix
    phone_number.to_s[4..10]
  end
end
