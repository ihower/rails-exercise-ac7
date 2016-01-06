class ApiV1::AuthController < ApiController

  before_action :authenticate_user!, :only => [:logout]

  def login
    user = User.find_by_email( params[:email] )
    if user && user.valid_password?( params[:password] )
      render :json => { :message => "Ok",
                        :auth_token => user.authentication_token,
                        :user_id => user.id }
    else
      render :json => { :message => "Email or Password is wrong" }, :status => 401
    end
  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :message => "Ok"}
  end

end
