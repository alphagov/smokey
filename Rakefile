require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new("test:integration",
    "Run all tests that are valid in our integration environment") do |t|
  t.profile = "integration"
  t.cucumber_opts = %w{--format progress -t ~@pending}
end

Cucumber::Rake::Task.new("test:production",
    "Run all tests that are valid in our production environment") do |t|
  t.profile = "production"
  t.cucumber_opts = %w{--format progress -t ~@pending}
end

Cucumber::Rake::Task.new("test:notlocalnetwork",
    "Run all tests that do not make use of the local network") do |t|
  t.cucumber_opts = %w{--format pretty -t ~@pending -t ~@local-network}
end

Cucumber::Rake::Task.new("test:wip",
  "Run only tests tagged @wip") do |t|
  t.cucumber_opts = %w{--format pretty -t @wip}
end

Cucumber::Rake::Task.new(:remote, "Excludes nagios tests") do |t|
  t.cucumber_opts = %w{--format pretty -t ~@pending -t ~@disabled_in_icinga}
end

task :default => "test:notlocalnetwork"
