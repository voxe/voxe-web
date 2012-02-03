Given /^I am on the elections page$/ do
  visit '/admin#elections'
  page.should have_content 'Elections'
  page.should have_content 'Ajouter une Election'
end

Given /^There is a published election$/ do
  @election = Factory :election, published: true
end

Given /^There is an unpublished election$/ do
  @election = Factory :election, published: false
end

Then /^The election shoud be unpublished$/ do
  @election.reload
  @election.published.should be false
end

Then /^The election shoud be published$/ do
  @election.reload
  @election.published.should be true
end
