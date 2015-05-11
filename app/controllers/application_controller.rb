class ApplicationController < ActionController::Base

before_filter :set_headers

def index
  puts "Do nothing."
  render nothing: true
end

def set_headers
  puts 'ApplicationController.set_headers'
  if request.headers["HTTP_ORIGIN"]     
  # better way check origin
  # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
    headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
    headers['Access-Control-Max-Age'] = '86400'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end
end  

  private
  def authenticate_user_from_token!
    user_id = params[:user_id].presence
    user = user_id && User.find_by_id(user_id)
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      @current_user = user
    else
      permission_denied
    end
  end

  def permission_denied
    render :file => "public/404.html", :status => :unauthorized, :layout => false
  end

end