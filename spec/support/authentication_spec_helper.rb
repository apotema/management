# -*- encoding : utf-8 -*-
module AuthenticationSpecHelper
    
  def login user
    visit login_path
    fill_in "Login", with: user.login
    fill_in "Password", with: "123456"
    click_button "Login"
  end

end