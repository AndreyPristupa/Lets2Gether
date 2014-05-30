class User < ActiveRecord::Base
  include TheComments::User
  has_many :projects
  has_many :payments
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

      # VK HASH EXAMPLE
      #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash
      #     expires=true expires_at=1401515103
      #     token="f6bae4a049486b543aed746b0989b84ebc0f9752cec94ea7c2915e3f6d414735a608a347e4e7cfda04b5a3566ec0d">
      # extra=#<OmniAuth::AuthHash
      #   raw_info=#<OmniAuth::AuthHash
      #       bdate="6.3.1990"
      #       city=314
      #       country=2
      #       first_name="Андрюша"
      #       id=182319070
      #       last_name="Уже-Не-Торт"
      #       nickname=""
      #       online=1
      #       photo_100="http://cs620224.vk.me/v620224070/5c61/HxB--Qp9AB0.jpg"
      #       photo_200_orig="http://cs620224.vk.me/v620224070/5c5e/L02whK7ynes.jpg"
      #       photo_50="http://cs620224.vk.me/v620224070/5c62/zis60bx4gAk.jpg"
      #       screen_name="kievcookie"
      #       sex=2>>
      # info=#<OmniAuth::AuthHash::InfoHash
      #     first_name="Андрюша"
      #     image="http://cs620224.vk.me/v620224070/5c62/zis60bx4gAk.jpg"
      #     last_name="Уже-Не-Торт"
      #     location="Украина, Киев"
      #     name="Андрюша Уже-Не-Торт"
      #     nickname=""
      # urls=#<OmniAuth::AuthHash
      #     Vkontakte="http://vk.com/kievcookie">>
      #     provider="vkontakte"
      #     uid="182319070">

      #TODO To many information in one column... Separate USER table to USER & USER_DESCRIPTION, e/g
      token = Devise.friendly_token[0,6]

      User.create!(
                   :provider  => access_token.provider,
                   :image     => access_token.extra.raw_info.photo_200_orig,
                   :firstname => access_token.info.first_name,
                   :nickname  => access_token.info.name,
                   :lastname  => access_token.info.last_name,
                   :url       => access_token.info.urls.Vkontakte,
                   :nickname  => access_token.info.name,
                   :email     => "#{token}@vk.com",
                   :password => token
      )
    end
  end
end