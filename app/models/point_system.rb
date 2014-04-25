class PointSystem < ActiveRecord::Base
  attr_protected
  belongs_to      :season

  def pts_for(nr)
    send("pts_#{nr}")
  end
end
