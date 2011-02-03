begin
  require 'rspec/core/rake_task'
rescue LoadError
  task(:spec) { $stderr.puts '`gem install rspec` to run specs' }
else
  desc "Run specs"
  RSpec::Core::RakeTask.new(:spec)
end