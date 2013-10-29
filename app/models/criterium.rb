class Criterium < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: "user_criteria"
  has_many :scores

  def score_for_scorecard(scorecard)
    return @score_stub || scorecard.scores.find {|s| s.criterium_id == self.id} ||
        @score_stub = Score.create_for_scorecard_and_criterium(scorecard, self)
  end

end
