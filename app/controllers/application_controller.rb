class ApplicationController < ActionController::API
  # Use callbacks to share common setup or constraints between actions.
  def get_current_user
    token = request.headers['HTTP_AUTHORIZATION']

    if token
      user_infor = Auth.decode(token)
      @user ||= User.find(user_info['user_id'])
    end

    @user
  end

  def password
    password = Base64.encode64('d64068e08bebe12456c64df5ab5599d0:c1d7e9717d853f7bc6ee5d003bab2df5')
    password = 'Basic ' + password.to_s
  end
end
