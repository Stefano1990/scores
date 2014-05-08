class CreateTeamStandingGraphics < ActiveRecord::Migration
  def change
    create_table :team_standing_graphics do |t|
      t.integer :standing_id, allow_nil: false, foreign_key: true
      t.integer :first_pos, allow_nil: false
      t.integer :last_pos, allow_nil: false
      t.string :image_name, allow_nil: false
      t.string :image_uid, allow_nil: false
      t.string :url, allow_nil: false

      t.timestamps
    end
  end
end
