require 'rubygems'
require 'cucumber/rake/task'

%w(training integration staging staging_aws production production_aws).each do |environment|
  Cucumber::Rake::Task.new("test:#{environment}",
      "Run all tests that are valid in our #{environment} environment") do |t|
    t.profile = environment
    t.cucumber_opts = %W{ENVIRONMENT=#{environment} --format pretty -t "not @benchmarking"}
  end
end
