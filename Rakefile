require "bundler/gem_tasks"

begin
  require 'byebug'
  require 'rspec/core/rake_task'
  
  #
  # FIXME: we need to set the ruby options to -W0 to silence the warnings connected
  # to the reassignement of the RUBY_PLATFORM constant value for testing purposes
  #
  RSpec::Core::RakeTask.new(:spec => 'fixtures:C:build') { |t| t.ruby_opts = '-W0' }
rescue LoadError
  # no rspec available
end

task :default => :spec

#
# Load all other rake tasks that reside in lib/tasks
#
Dir.glob(File.expand_path(File.join('..', 'lib', 'tasks', '**', '*.rake'), __FILE__)).each { |f| load f }
