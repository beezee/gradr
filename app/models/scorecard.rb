class Scorecard < ActiveRecord::Base
  belongs_to :grader, class_name: 'User'
  belongs_to :gradee, class_name: 'User'
  has_many :scores

  def self.create_for_url_by_grader(url, grader)
    scorecard = Scorecard.new
    scorecard.url = url.strip
    scorecard.grader = grader
    scorecard.gradee_id = 0
    scorecard.save
    scorecard
  end
    
end
