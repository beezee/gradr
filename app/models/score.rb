class Score < ActiveRecord::Base
  belongs_to :scorecard
  belongs_to :criterium

  def self.create_for_scorecard_and_criterium(scorecard, criterium)
    score = Score.new
    score.scorecard = scorecard
    score.criterium = criterium
    score.score = 10
    score.save
    score
  end

end
