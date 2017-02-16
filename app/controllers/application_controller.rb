class ApplicationController < ActionController::API
  # Use callbacks to share common setup or constraints between actions.
  def get_current_user
    token = request.headers['HTTP_AUTHORIZATION']
    binding.pry

    if token
      user_info = Auth.decode(token)
      @user ||= User.find(user_info['user_id'])
    end

    binding.pry
    @user
  end

  def password
    password = Base64.encode64('d64068e08bebe12456c64df5ab5599d0:c1d7e9717d853f7bc6ee5d003bab2df5')
    password = 'Basic ' + password.to_s
  end

  def api_call(url)
    all_stocks = RestClient.get(url, {:'Authorization' => password })
    response = JSON.parse(all_stocks)
  end
end
