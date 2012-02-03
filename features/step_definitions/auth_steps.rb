# encoding: utf-8
Given /^I am a logged admin$/ do
  @current_user = Factory :admin,
    email: 'admin@voxe.org',
    password: 'password',
    password_confirmation: 'password'
  visit '/users/sign_in'
  fill_in 'user_email', with: 'admin@voxe.org'
  fill_in 'user_password' , with: 'password'
  click_button 'Sign in'
end
