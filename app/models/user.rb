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
      nu = User.new(:provider => access_token.provider, :first_name => access_token.info.first_name, :url => access_token.info.urls.Vkontakte, :nickname => access_token.info.name, :email => "#{token}@vk.com", :password => token)

      logger.info "#{access_token.provider}"
      logger.info "#{access_token.info.urls.Vkontakte}"
      logger.info "#{access_token.info.name}"
      logger.info "#{access_token.extra.raw_info.domain}@vk.com"
      logger.info "#{}"

      logger.info "#{nu.inspect}"
      nu.save!
    end
  end
end