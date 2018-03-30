# frozen_string_literal: true

# https://stackoverflow.com/questions/9017158/running-ruby-unit-tests-with-rake

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
# require 'lib/test_text_exclude.rb'
require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end
