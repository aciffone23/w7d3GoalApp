require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "should render new page " do 
      get new_user_url 
      expect(response.body).to include("Sign Up")
    end

    # it "should have a input for username"
    # it "should have a input for password"
    # it "should have a button for sign up"

    #   context "with valid inputs" do 
    #     it "should create user"
    #     it "should redirect to show page"
    #   end

    #   context "with invalid inputs" do 
    #     it "should render new page"
    #     it "should have error messages"
    # end
  end

  # describe "POST /users (#create)" do
  #   it " " do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe "GET /users/:id (#show)" do
    it "should show users username" do 
      FactoryBot.create(:user)
      user2 = User.find_by(id: User.last.id)
      get user_url(user2)
      expect(response.body).to include(user2.username)
    end
  end

  describe "GET /users (#index)" do
    it "should show list all users" do 
      FactoryBot.create(:user)
      user1 = User.find_by(id: User.last.id)
      FactoryBot.create(:user)
      user2 = User.find_by(id: User.last.id)
      get users_url
      expect(response.body).to include(user2.username)
      expect(response.body).to include(user1.username)
    end
  end

  # describe "DELETE /users/:id" do
  #   it "" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
