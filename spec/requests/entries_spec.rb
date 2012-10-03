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

end