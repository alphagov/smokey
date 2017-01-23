require 'json'

Then /^JSON is returned$/ do
  JSON.parse(page.body).class.should == Hash 
end
