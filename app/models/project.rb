class Project < ActiveRecord::Base
  include Bootsy::Container
  include Paperclip::Glue
  include TheComments::Commentable

  belongs_to :user
  belongs_to :category

  scope :category_id, lambda { |value| where('categories.id = ?', value) if value.is_a? Integer }
  scope :q, lambda { |value| where('projects.name LIKE ?', "%#{value}%") if !value.empty? }

  validates :name, :start_at, :end_at, :description, :start_at, :end_at, presence: true
  validates :name, length: { in: 4..100, too_long: I18n.t(:too_long_field), too_short: I18n.t(:too_short_field) }
  validates :description, length: { in: 100...50000, too_long: I18n.t(:too_long_field), too_short: I18n.t(:too_short_field) }
  validate :date_fields

  attr_accessor :image

  has_attached_file :image, :styles => {:small => '200x250>', :medium => '300x300>', :thumb => '100x100>', :big => '500x500>' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.related
    order(views: :asc).limit(4)
  end

  def self.latest
    order(created_at: :desc).limit(4)
  end

  def commentable_title
    'Undefined Post Title'
  end

  def commentable_url
    '#'
  end

  def commentable_state
    'published'
  end
private
  def update_object
    self.user_id = 2
  end
end

  def date_fields
    if self.start_at.to_i > self.end_at.to_i
      errors.add(:start_at, I18n.t(:date_is_not_valid))
    end
  end