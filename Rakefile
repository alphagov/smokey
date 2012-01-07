require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:test) do |t|
    t.cucumber_opts = %w{--format pretty -t ~@pending}
end

Cucumber::Rake::Task.new(:nagios) do |t|
    t.cucumber_opts = %w{--format Cucumber::Formatter::Nagios -t ~@pending -t ~@notnagios}
end

namespace :smokey do

  desc "Deploy smokey for use by nagios to $HOST"
  task :deploy do
    command = "rsync --exclude .git --compress --verbose --recursive --delete . -e 'ssh -i #{ENV['HOME']}/.ssh/beta.pem' ubuntu@#{ENV['HOST']}:/opt/smokey"
    puts command
    system command
  end

end
