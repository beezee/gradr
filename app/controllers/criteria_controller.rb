class CriteriaController < ApplicationController

  def create
    if (!params[:name] || params[:name].empty?)
      return render json: {error: 'Criteria name is required'}
    end
    if current_user.criteria.count >= 8
      return render json: {error: 'Maximum of 8 criteria allowed'}
    end
    criterium = Criterium.find_or_create_by_name(params[:name])
    current_user.criteria << criterium
    render json: {status: 'Success'}
  end

  def remove
    if (!params[:id] || params[:id].empty? || !criterium = Criterium.find(params[:id]))
      return render json: {error: 'No criteria specified'}
    end
    current_user.criteria.delete criterium
    render json: {status: 'Success'}
  end

end
