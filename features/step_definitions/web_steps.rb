When /^I click on "([^"]*)" button$/ do |button|
  click_button button
end

Then /^I shoud see "([^"]*)" on the page$/ do |content|
  page.should have_content content
end
