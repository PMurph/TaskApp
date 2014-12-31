Given /^I am on the "([^"]*)" page$/ do |page_name|
    visit get_path_to(page_name)
end

When /^I create a new user$/ do
    pending
end

Then /^I should see user creation successful page for the new user$/ do
    pending
end
