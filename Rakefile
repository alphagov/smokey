require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new("test:integration",
    "Run all tests that are valid in our integration environment") do |t|
  t.profile = "integration"
  t.cucumber_opts = %w{ENVIRONMENT=integration --format pretty -t "not @benchmarking"}
end

Cucumber::Rake::Task.new("test:staging",
                         "Run all tests that are valid in our staging environment") do |t|
  t.profile = "staging"
  t.cucumber_opts = %w{ENVIRONMENT=staging --format pretty -t "not @benchmarking"}
end

Cucumber::Rake::Task.new("test:staging-aws",
                         "Run all tests that are valid in our aws staging environment") do |t|
  t.profile = "staging"
  t.cucumber_opts = %w{ENVIRONMENT=staging-aws --format pretty -t "not @benchmarking"}
end

Cucumber::Rake::Task.new("test:production",
    "Run all tests that are valid in our production environment") do |t|
  t.profile = "production"
  t.cucumber_opts = %w{ENVIRONMENT=production --format pretty -t "not @benchmarking"}
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
