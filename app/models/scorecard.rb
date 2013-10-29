class Scorecard < ActiveRecord::Base
  belongs_to :grader, class_name: 'User'
  belongs_to :gradee, class_name: 'User'
  has_many :scores
  validates_presence_of :grader
  validate :ensure_gradee_exists

  def ensure_gradee_exists
    errors.add('gradee') unless self.gradee_id == 0 || self.gradee
  end

  def self.create_for_url_by_grader(url, grader)
    scorecard = Scorecard.new
    scorecard.url = url.strip
    scorecard.grader = grader
    scorecard.gradee_id = 0
    scorecard.save
    scorecard
  end

  def scored_points
    self.scores.to_a.collect {|s| s.score}
  end

  def average_score
    self.scored_points.sum / self.scores.size rescue 0
  end

end
