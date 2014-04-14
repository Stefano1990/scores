class Driver < ActiveRecord::Base
  belongs_to    :graphic
  attr_protected
  has_paper_trail
end
