class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :project


  def self.success
    limit(3)
  end
end
