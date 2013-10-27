class ScorecardsController < ApplicationController

  def edit
    if !params[:url] || params[:url].empty?
      return not_found
    end
    @scorecard = Scorecard.find_by(url: params[:url], grader_id: current_user.id) || 
        Scorecard.create_for_url_by_grader(params[:url], current_user)
    respond_to do |f|
      f.html { render layout: false }
    end
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
end
