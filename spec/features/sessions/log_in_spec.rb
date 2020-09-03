require 'rails_helper'

describe "login page" do
  before :each do 
    @user = User.create!(username: "funbucket13", password: "test")

  end
  it "can log in with valid credentials" do
    visit "/"

    click_on "Login"
    expect(current_path).to eq('/login')

    username = "funbucket13"
    password = "test"

    within(".form") do
      fill_in :username, with: @user.username
      fill_in :password, with: @user.password
      click_on "Login"
    end

    expect(current_path).to eq("/")

    visit '/profile'

    expect(page).to have_content("Hello, #{username}!")
  end

  it "cannot log in with bad credentials" do
  visit "/"

  click_on "Login"

  within(".form") do
    fill_in :username, with: @user.username
    fill_in :password, with: "incorrect password"
    click_on "Login"
  end

  expect(current_path).to eq('/login')

  expect(page).to have_content("Sorry, incorrect password.")
  end
end