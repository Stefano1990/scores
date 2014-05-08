class Track < ActiveRecord::Base
  has_many    :rounds
  attr_accessible :iracing_name, :name
end
