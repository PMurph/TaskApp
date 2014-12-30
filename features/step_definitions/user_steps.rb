Given /^I am on the "([^"]*)" page$/ do |page_name|
    visit get_path_to(page_name)
end