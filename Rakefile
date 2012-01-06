require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:test) do |t|
  t.cucumber_opts = %w{--format pretty -t ~@pending}
end

Cucumber::Rake::Task.new(:nagios) do |t|
  t.cucumber_opts = %w{--format Cucumber::Formatter::Nagios -t ~@pending}
end

