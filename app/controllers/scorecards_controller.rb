class ScorecardsController < ApplicationController

  def edit
    @skip_header = true
    response.headers['X-Frame-Options'] = 'GOFORIT'
    if !params[:url] || params[:url].empty?
      return not_found
    end
    @scorecard = Scorecard.find_by(url: params[:url], grader_id: current_user.id) || 
        Scorecard.create_for_url_by_grader(params[:url], current_user)
  end

  def invite_gradee
    if !scorecard = current_user.grader_scorecards.find(params[:id])
      return render json: {error: 'Invalid scorecard specified'}
    end
    gradee = User.new.invite params[:value], type: 'added_to_scorecard', grader: current_user
    if gradee.errors.any? 
      return render json: {error: gradee.errors.full_messages.first}
    end
    scorecard.gradee = gradee
    scorecard.save
    render json: {status: 'Success'}
  end

  def save
    if !scorecard = current_user.grader_scorecards.find(params[:id])
      return render json: {error: 'Invalid scorecard specified'}
    end
    scorecard.gradee_id = params[:gradee_id]
    scorecard.save
    if scorecard.errors.any?
      return render json: {error: scorecard.errors.full_messages.first}
    end
    params[:scores].each do |id, score|
      if score_record = scorecard.scores.find(id)
        score_record.score = score
        score_record.save
      end
    end      
    render json: {status: 'Success'}
  end

end
