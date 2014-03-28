class Driver < ActiveRecord::Base
  belongs_to    :graphic
  attr_protected
end
