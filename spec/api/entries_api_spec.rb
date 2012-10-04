require "spec_helper"

describe Api::EntriesController do

  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:user) { FactoryGirl.create :user }
  let!(:user_unauthorized) { FactoryGirl.create :user }
  let!(:application) { Doorkeeper::Application.create!(name: "MyApp", redirect_uri: "http://localhost:3000") }
  let!(:token) { Doorkeeper::AccessToken.create! application_id: application.id, resource_owner_id: user.id }

  let!(:entry) { FactoryGirl.create(:entry, user: user) }
  let!(:entry_unauthorized) { FactoryGirl.create(:entry, user: user_unauthorized) }

  describe "GET /api/entries" do

    let!(:entries) { FactoryGirl.create_list(:entry, 10,user: user) }

    it "should return the user entries" do
      get "/api/entries", format: :json, access_token: token.token
      last_response.status.should be_eql 200
      entries.each{|entry| last_response.body.should include entry.name}
    end

    it "should return have other users entries" do
      get "/api/entries", format: :json, access_token: token.token
      last_response.status.should be_eql 200
      last_response.body.should_not include entry_unauthorized.name
    end

  end

  describe "GET /entry/:id" do

    it "returns the entry data" do
      get "/api/entries/#{entry.id}", format: :json, access_token: token.token 
      last_response.status.should be_eql 200
    end

    it "should not returns the entry data of other users" do
      get "/api/entries/#{entry_unauthorized.id}", format: :json, access_token: token.token 
      last_response.status.should be_eql 401
    end

  end

  describe "POST /api/entries" do
    it "Create the entry" do
      post "/api/entries", entry: {name: "entry_name", priority: 5}, format: :json, access_token: token.token 
      last_response.status.should be_eql 201
      Entry.all.count.should be_eql 3
    end
  end

  describe "PUT /api/entries/:id" do

    it "updates the entry" do
      put "/api/entries/#{entry.id}", entry: {name: "new_entry_name", priority: 33}, format: :json, access_token: token.token 
      last_response.status.should be_eql 204

      edited_entry = Entry.find(entry.id)
      edited_entry.name.should be_eql "new_entry_name"
      edited_entry.priority.should be_eql 33
    end

    it "should not updates others users entry" do
      put "/api/entries/#{entry_unauthorized.id}", entry: {name: "new_entry_name", priority: 33}, format: :json, access_token: token.token 
      last_response.status.should be_eql 401

      edited_entry = Entry.find(entry_unauthorized.id)
      edited_entry.name.should_not be_eql "new_entry_name"
      edited_entry.priority.should_not be_eql 33
    end
  end

  describe "DELETE /api/entries/:id" do

    it "removes the entry" do
      delete "/api/entries/#{entry.id}", format: :json, access_token: token.token 
      last_response.status.should be_eql 204
      Entry.all.count.should be_eql 1
    end

    it "should not removes other users entries" do
      delete "/api/entries/#{entry_unauthorized.id}", format: :json, access_token: token.token 
      last_response.status.should be_eql 401
      Entry.all.count.should be_eql 2
    end

  end

end