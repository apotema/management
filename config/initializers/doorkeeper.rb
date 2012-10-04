Doorkeeper.configure do
  resource_owner_from_credentials do |routes|
    user = User.find_by_email(params[:username])
    user if (user && user.authenticate(params[:password]) && (user.disabled == nil ))
  end
end