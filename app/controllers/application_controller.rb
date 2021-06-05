class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :no_record_found

  def no_record_found
    render json: JSON.generate({ 
      error: 'No match for that query'
     }), status: 400
  end
  
end
