require "spec_helper"

describe "User administration" do
  
  describe "User registration" do
    
    before {visit new_user_path}

    it "should register a valid user" do
      fill_in "Name", with: "user_name" 
      fill_in "Password", with: "123456"
      fill_in "Login", with: "apotema"
      fill_in "Password confirmation", with: "123456"
      click_button "Create User"
      page.should have_content("user_name")
    end

    it "should not register a invalid user" do
      fill_in "Name", with: "user_name" 
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
      click_button "Create User"
      page.should have_css('.error')
    end

  end

  describe "User visualization" do

    let!(:user) { FactoryGirl.create :user }
    let!(:entries) { FactoryGirl.create_list :entry, 10, user: user }
    let!(:entry) { entries.last }

    before { visit user_path(user) }

    it "should list all user entries" do
      entries.each do |entry|
        page.should have_content entry.name
      end
    end

    it "shoul delete a entry" do
      page.find(:xpath,"//table//tr/td[contains(.,'#{entry.name}')]/../td/a[contains(.,'Delete')]").click
      page.should_not have_content entry.name
    end

  end

end