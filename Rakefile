require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new("test:localnetwork",
    "Run all tests including those which depend on being on " +
    "the same local network as other production infrastructure") do |t|
  t.cucumber_opts = %w{--format pretty -t ~@pending}
end

Cucumber::Rake::Task.new("test:notlocalnetwork",
  "Run all tests except those which must be on " +
  "the same local network as other production infrastructure") do |t|
  t.cucumber_opts = %w{--format pretty -t ~@pending -t ~@local-network}
end

Cucumber::Rake::Task.new(:remote, "Excludes nagios tests") do |t|
  t.cucumber_opts = %w{--format pretty -t ~@pending -t ~@notnagios}
end

Cucumber::Rake::Task.new(:nagios, "Output test results in a format consumable by Nagios monitoring system") do |t|
  t.cucumber_opts = %w{--format Cucumber::Formatter::Nagios -t ~@pending -t ~@notnagios}
end

task :default => "test:notlocalnetwork"

namespace :smokey do

  desc "Deploy smokey for use by nagios to $HOST"
  task :deploy do
    command = "ssh -l ubuntu #{ENV['HOST']} -i #{ENV['HOME']}/.ssh/beta.pem sudo mkdir /opt/smokey"
    puts command
    system command
    command = "ssh -l ubuntu #{ENV['HOST']} -i #{ENV['HOME']}/.ssh/beta.pem sudo chown -R ubuntu:root /opt/smokey"
    puts command
    system command
    command = "rsync --exclude .git --compress --verbose --recursive --delete . -e 'ssh -i #{ENV['HOME']}/.ssh/beta.pem' ubuntu@#{ENV['HOST']}:/opt/smokey"
    puts command
    system command
  end

end
