class Driver < ActiveRecord::Base
  belongs_to    :league
  attr_protected
end
