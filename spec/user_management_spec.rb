require 'spec_helper'
require_relative 'helpers/session'

include SessionHelper

feature "User signs up" do

  scenario "when being logged out" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, rich@example.com")
    expect(User.first.email).to eq("rich@example.com")
  end

  scenario "with a password that doesnt match" do
    expect{ sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with an email that is already registered" do
    expect { sign_up }.to change(User, :count).by(1)
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content("This email is already taken") 
  end

  def sign_up(email = "rich@example.com",
              password = "apples!",
              password_confirmation = "apples!")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

end

feature "User signs in" do

  before(:each) do
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'test')
    expect(page).to have_content("Welcome, test@test.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end
  
end

feature 'User signs out' do 

  before(:each) do
    User.create(:email => 'test@test.com',
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end

feature "User can reset password" do

  before(:each) do
    User.create(:email => 'test@test.com',
                :password => 'test',
                :password_confirmation => 'test',
                :password_token => 'TESTER')
  end

  scenario 'user forgets password' do
    visit '/sessions/new'
    click_link "forgotten_password"
    expect(page).to have_content("Please enter your email")
    fill_in :email, :with => 'test@test.com'
    click_button("Submit")
    expect(page).to have_content("Please check your email")
  end

  scenario 'User resets password' do
    visit '/users/reset_password/TESTER'
    expect(page).to have_content('Please enter a new password')
  end

end