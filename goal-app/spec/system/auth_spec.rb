require 'rails_helper'

RSpec.describe "Auth", type: :system do
    before do
        driven_by(:rack_test)
    end

    describe "the sign up process" do
        it "has a new user page" do
            visit new_user_url
            expect(page).to have_content "Sign Up"
        end

        it "shows username on the homepage after signup" do
            visit new_user_url
            fill_in 'username', with: 'testusername'
            fill_in 'password', with: 'password'
            click_on 'Create User'
            expect(page).to have_content 'testusername'
        end
    end

    describe "logging in" do
        it "shows username on the homepage after login"
    end

    describe "logging out" do
        it "begins with a logged out state"
        it "doesn't show username on the homepage after logout"
    end
end
