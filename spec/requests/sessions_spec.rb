require "spec_helper"

describe "Authentication" do
  
  describe "user login" do
    
    let!(:user) { FactoryGirl.create :user }
    before{ visit login_path }

    it "should login a valid user" do
      fill_in "Login", with: user.login
      fill_in "Password", with: "123456"
      click_button "Login"
      page.should have_content user.name
    end

    it "should not login a invalid user" do
      fill_in "Login", with: user.login
      fill_in "Password", with: "1111111"
      click_button "Login"
      page.should_not have_content user.name
      page.should have_css('.alert')
    end

  end

end