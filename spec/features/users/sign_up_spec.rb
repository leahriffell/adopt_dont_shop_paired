require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit "/"

    click_on "Sign up"

    expect(current_path).to eq("/users/sign_up")

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Register"

    expect(page).to have_content("Welcome, #{username}!")
  end

  it "keeps a user logged in after registering" do
    User.create!(username: "funbucket13", password: "test")

    visit "/"

    click_on "Login"
    expect(current_path).to eq('/login')

    username = "funbucket13"
    password = "test"

    within(".form") do
      fill_in :username, with: username
      fill_in :password, with: password
      click_on "Login"
    end

    expect(current_path).to eq("/")

    visit '/profile'

    expect(page).to have_content("Hello, #{username}!")
  end
end