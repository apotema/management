require "spec_helper"

describe "Todo List administration" do
  
  let!(:user) { FactoryGirl.create :user }
  
  describe "entry add" do
    
    before do
      login user
      visit new_entry_path
    end

    it "should add a valid entry" do
      fill_in "Name", with: "entry name" 
      fill_in "Priority", with: "1"
      click_button "Create Entry"
      page.should have_content("entry name")
    end

    it "should not add a invalid entry" do
      fill_in "Name", with: "entry name" 
      click_button "Create Entry"
      page.should have_css('.error')
    end

  end

  describe "entry edit" do

    let!(:entry) { FactoryGirl.create :entry, user: user }
    
    before do
      login user
      visit edit_entry_path(entry)
    end

    it "should edit the entry values" do
      fill_in "Name", with: "entry new name"
      fill_in "Priority", with: "5"
      click_button "Update Entry"
      page.should have_content("entry new name")
    end

    it "should not save a invalid entry" do
      fill_in "Name", with: ""
      fill_in "Priority", with: "5"
      click_button "Update Entry"
      page.should have_css('.error')
    end

  end

  describe "entry destroy" do
    
    let!(:user) { FactoryGirl.create :user }
    let!(:entries) { FactoryGirl.create_list :entry, 10, user: user }
    let!(:entry) { entries.last }

    before { login user } 

    it "should destroy a given entry", js: true do
      page.find(:xpath,"//table//tr/td[contains(.,'#{entry.name}')]/../td/a[contains(.,'Delete')]").click
      page.driver.browser.switch_to.alert.accept
      page.should_not have_content entry.name
    end

  end

  describe "entry authorization" do

    let!(:user_unauthorized) { FactoryGirl.create :user }
    let!(:entry_unauthorized) { FactoryGirl.create :entry, user: user_unauthorized }
    
    before { login user } 

    it "should not allow the user to edit other users entries" do
      visit edit_entry_path(entry_unauthorized)
      page.should have_css('.alert')
    end

    it "should not allow the user to view other users entries" do
      visit entry_path(entry_unauthorized)
      page.should have_css('.alert')
    end

  end

end