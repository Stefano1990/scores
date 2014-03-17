class League < ActiveRecord::Base
  belongs_to      :user
  has_many        :drivers
  has_many        :standings
  has_many        :results

  dragonfly_accessor :background

  attr_accessible   :name, :user_id, :url, :config, :background, :background_uid
  validate          :name, presence: true

  def get_driver_list(url_to_parse)

  end

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

  def expire_standings_and_results!
    # Because the config and or background has changed all the standings/results are outdated graphics.
    results.each do |result|
      result.status = 'outdated'
      result.save
    end
    standings.each do |standing|
      standing.status = 'outdated'
      standing.save
    end
  end
end
