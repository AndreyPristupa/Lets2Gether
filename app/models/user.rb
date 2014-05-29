class User < ActiveRecord::Base
  include TheComments::User
  has_many :projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         :omniauth_providers => [:facebook, :vkontakte]

  #validates :firstname, :lastname, presence: true

  def admin?
    self == User.first
  end

  def comments_admin?
    admin?
  end

  def comments_moderator? comment
    id == comment.holder_id
  end

  def self.find_for_vkontakte_oauth access_token


    user = User.where(:url => access_token.info.urls.Vkontakte).first
    if user
      user
    else
      token = Devise.friendly_token[0,6]
      logger.info access_token.inspect
      User.create!(:provider => access_token.provider, :image => access_token.info.image_50, :url => access_token.info.urls.Vkontakte, :nickname => access_token.info.name, :email => "#{token}@vk.com", :password => token)
    end
  end
end