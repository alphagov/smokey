require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new("test:preview",
    "Run all tests that are valid in our preview environment") do |t|
  t.cucumber_opts = %w{--format progress -t ~@pending -t ~@notpreview}
end

Cucumber::Rake::Task.new("test:draft",
    "Run all tests that are valid in our draft environment") do |t|
  t.cucumber_opts = %w{--format progress -t ~@pending -t @draft}
end

Cucumber::Rake::Task.new("test:preview_draft",
    "Run all tests that are valid in our preview draft environment") do |t|
  t.cucumber_opts = %w{--format progress -t @draft -t ~@pending -t ~@notpreview}
end

Cucumber::Rake::Task.new("test:skyscapenetwork",
    "Run all tests that are valid in our production environment") do |t|
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
