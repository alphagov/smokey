require 'rubygems'
require 'cucumber/rake/task'

%w(training integration staging staging_aws production production_aws).each do |environment|
  Cucumber::Rake::Task.new("test:#{environment}",
      "Run all tests that are valid in our #{environment} environment") do |t|
    t.profile = environment
    t.cucumber_opts = %W{ENVIRONMENT=#{environment} --format pretty -t "not @benchmarking"}
  end
end

Cucumber::Rake::Task.new("test:notlocalnetwork",
    "Run all tests that do not make use of the local network") do |t|
  t.cucumber_opts = %w{ENVIRONMENT=production --format pretty -t "not @pending" -t "not @local-network"}
end

Cucumber::Rake::Task.new("test:wip",
  "Run only tests tagged @wip") do |t|
  t.cucumber_opts = %w{ENVIRONMENT=production --format pretty -t @wip}
end

Cucumber::Rake::Task.new(:remote, "Excludes Nagios tests") do |t|
  t.cucumber_opts = %w{ENVIRONMENT=production --format pretty -t "not @pending" -t "not @disabled_in_icinga"}
end

task :default => "test:notlocalnetwork"
