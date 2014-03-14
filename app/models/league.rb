class League < ActiveRecord::Base
  belongs_to      :user
  has_many        :drivers
  has_many        :standings
  attr_accessible :name, :user_id, :url
  validates       :url, presence: :true

  def refresh
    doc = Nokogiri::HTML(open(url))
    doc.css('table#driver_table tr.jsTableRow').each do |row|
      name = row.children[1].text
      driver = drivers.find_or_initialize_by_name(name)
      driver.pos = row.children[0].text.to_i
      driver.team = row.children[2].text
      driver.starts = row.children[3].text.to_i
      driver.wins = row.children[4].text.to_i
      driver.top5 = row.children[5].text.to_i
      driver.top10 = row.children[6].text.to_i
      driver.tot_pts = row.children[7].text.to_i
      driver.bns_pts = row.children[8].text.to_i
      driver.laps = row.children[9].text.to_i
      driver.beh_lead = row.children[10].text.to_i
      driver.beh_next = row.children[11].text.to_i
      driver.save if driver.changed?
    end
  end
end
