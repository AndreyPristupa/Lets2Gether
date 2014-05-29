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

      nu = User.new(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte, :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain, :email => "#{access_token.extra.raw_info.domain}@vk.com", :password => Devise.friendly_token[0,20])
      logger.info "#{access_token.provider}"
      logger.info "#{access_token.info.urls.Vkontakte}"
      logger.info "#{access_token.info.name}"
      logger.info "#{access_token.extra.raw_info.domain}@vk.com"
      logger.info "#{Devise.friendly_token[0,20]}"

      logger.info "#{nu.inspect}"
      nu.save!
    end
  end
end