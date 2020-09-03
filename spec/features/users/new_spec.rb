require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit "/"

    click_on "Sign up"

    expect(current_path).to eq("/users/new")

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Register"

    expect(page).to have_content("Welcome, #{username}!")
  end

  it "keeps a user logged in after registering" do
    visit "/"

    click_on "Sign up"

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Register"

    visit '/profile'

    expect(page).to have_content("Hello, #{username}!")
  end
end