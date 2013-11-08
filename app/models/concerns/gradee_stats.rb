module GradeeStats
  extend ActiveSupport::Concern

  def average_score_by_grader_since(grader_id, since=2.months.ago)
    scores = self.gradee_scorecards.select {|s| s.grader_id == grader_id and s.updated_at >= since}.
                      flat_map {|s| s.scores.pluck(:score)}
    (scores.sum.to_f / scores.size) rescue 0
  end

  def scorecards_by_grader_since(grader_id, since=2.months.ago)
     @scorecards_by_grader_since ||= {}
     @scorecards_by_grader_since["#{grader_id}#{since}"] ||=
      Scorecard.where('updated_at > ? and grader_id = ? and gradee_id = ?', since, grader_id, self.id)
            .order('updated_at ASC').preload(:scores)
  end

  def averages_by_grader_since(grader_id, since=2.months.ago)
     self.scorecards_by_grader_since(grader_id, since).collect{|s| s.average_score }
  end

  def average_by_grader_since(grader_id, since=2.months.ago)
    averages = self.averages_by_grader_since grader_id, since
    (averages.sum.to_f / averages.size).round(2) rescue 0
  end

end

