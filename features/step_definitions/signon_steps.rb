When /^I try to login as a user$/ do
  assert ENV["SIGNON_EMAIL"] && ENV["SIGNON_PASSWORD"], "Please ensure that the signon user credentials are available in the environment"
  @response = post_request "#{signon_base_url}/users/sign_in", :payload => "user[email]=#{ENV["SIGNON_EMAIL"]}&user[password]=#{ENV["SIGNON_PASSWORD"]}"
end

