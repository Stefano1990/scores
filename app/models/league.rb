class League < ActiveRecord::Base
  attr_accessible :user_id, :name
  belongs_to      :user
  has_many        :series

  def to_param
    "#{id}-#{name}"
  end
end
