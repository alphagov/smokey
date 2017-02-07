require 'json'

Then /^JSON is returned$/ do
  JSON.parse(@response.body).class.should == Hash
end
